# frozen_string_literal: true

namespace :alerts do
  desc 'Send alert digests to all users'
  task send_emails: :environment do
    # Run on Sundays at 5PM PST/6PM PDT
    send_emails
  end
end

def send_emails
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

  require 'alerts/emails/digest_data_generator'

  Rails.logger.debug 'alerts:send_emails - Starting task'

  users = User.all
  users.each do |user|
    generate_and_send_email(user)
  rescue StandardError => e
    send_error_email_and_notify(user, e)
  end

  Rails.logger.info 'alerts:send_emails - Task complete'
end

def generate_and_send_email(user)
  Rails.logger.info "alerts:send_emails - Generating email for User##{user.id}"

  alert_ids_and_days_of_week = Alerts::DigestDataGenerator.new(user.id).generate

  return unless alert_ids_and_days_of_week.any?

  AlertMailer.digest(user.id, alert_ids_and_days_of_week).deliver_now

  Rails.logger.info "alerts:send_emails - Email sent to User##{user.id}"
end

def send_error_email_and_notify(user, error)
  raise error unless Rails.env.production?

  Rails.logger.fatal "alerts:send_emails - Generation failed for User##{user.id}"
  Rollbar.error(error, "Email generation failed for User##{user.id}")
  AlertMailer.digest_error(user.id).deliver_now
end
