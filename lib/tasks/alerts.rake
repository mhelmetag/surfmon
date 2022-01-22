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
    # alert 1:
    #   - day 1
    # alert 2:
    #   - day 1
    #   - day 3
    # etc

    require 'alerts/emails/digest_data_generator'

    users = User.all

    users.each do |user|
      alert_ids_and_days_of_week = Alerts::Emails::DigestDataGenerator.new(user.id).generate

      AlertMailer.digest(user.id, alert_ids_and_days_of_week).deliver_now if alert_ids_and_days_of_week.any?
    rescue StandardError => e
      Rollbar.error(e, "Digest generation failed for User##{user.id}")
      AlertMailer.digest_error(user.id).deliver_now
    end
  end
end
