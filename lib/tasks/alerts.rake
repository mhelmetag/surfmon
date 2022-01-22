# frozen_string_literal: true

namespace :alerts do
  desc 'Send alert digests to all users'
  task send_emails: :environment do
    # Run on Sundays at 5PM PST/6PM PDT

    # grab all users
    # for each user, grab all alerts
    # group alerts into ones with a matching condition
    # if the condition is met for any of the days of the week
    # track the alerts and all days of the week that the condition is met
    # serialize the email as follows
    # alert 1: Monday, Wednesday
    # alert 2: Saturday
    # etc

    return if Rails.env.production? && (Time.now.in_time_zone('Pacific Time (US & Canada)').strftime('%A') != 'Sunday')

    Rails.logger.debug 'alerts:send_emails - Starting task'

    require 'alerts/emails/digest_data_generator'

    users = User.all

    users.each do |user|
      Rails.logger.info "alerts:send_emails - Generating email for User##{user.id}"
      alert_ids_and_days_of_week = Alerts::Emails::DigestDataGenerator.new(user.id).generate

      if alert_ids_and_days_of_week.any?
        AlertMailer.digest(user.id, alert_ids_and_days_of_week).deliver_now
        Rails.logger.info "alerts:send_emails - Email sent to User##{user.id}"
      end
    rescue StandardError => e
      Rails.logger.fatal "alerts:send_emails - Generation failed for User##{user.id}"
      Rollbar.error(e, "Email generation failed for User##{user.id}")
      AlertMailer.digest_error(user.id).deliver_now
    end

    Rails.logger.info 'alerts:send_emails - Task complete'
  end
end
