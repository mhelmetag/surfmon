# frozen_string_literal: true

namespace :alerts do
  desc 'Send alert digests to all users'
  task send_emails: :environment do
    send_emails
  end

  desc 'Send alert digests to me'
  task test_send_emails: :environment do
    test_send_emails
  end
end

def test_send_emails
  # Just send me an email

  return if prod_and_day_incorrect?

  require 'alerts/digest_data_generator'

  puts 'alerts:test_send_emails - Starting task'

  user = User.find_by(email: 'mhelmetag@gmail.com')
  generate_and_send_email(user)
end

def send_emails
  # Grab all users
  # for each user, grab all alerts
  # group alerts into ones with a matching condition
  # if the condition is met for any of the days of the week
  # track the alerts and all days of the week that the condition is met
  # serialize the email as follows
  # alert 1: Monday, Wednesday
  # alert 2: Saturday
  # etc

  return if prod_and_day_incorrect?

  require 'alerts/digest_data_generator'

  puts 'alerts:send_emails - Starting task'

  users = User.all
  users.each do |user|
    generate_and_send_email(user)
  rescue StandardError => e
    send_error_email_and_notify(user, e)
  end

  puts 'alerts:send_emails - Task complete'
end

def prod_and_day_incorrect?
  # When in production, only run on Sundays and Thursdays
  Rails.env.production? &&
    (
      Time.now.in_time_zone('Pacific Time (US & Canada)').strftime('%A') != 'Sunday' ||
      Time.now.in_time_zone('Pacific Time (US & Canada)').strftime('%A') != 'Thursday'
    )
end

def generate_and_send_email(user)
  puts "alerts:send_emails - Generating email for User##{user.id}"

  alert_ids_and_days_of_week = Alerts::DigestDataGenerator.new(user.id, days_to_check).generate

  return unless alert_ids_and_days_of_week.any?

  AlertMailer.digest(user.id, alert_ids_and_days_of_week).deliver_now

  puts "alerts:send_emails - Email sent to User##{user.id}"
end

def send_error_email_and_notify(user, error)
  raise error unless Rails.env.production?

  puts "alerts:send_emails - Generation failed for User##{user.id}"
  Rollbar.error(error, "Email generation failed for User##{user.id}")
  AlertMailer.digest_error(user.id).deliver_now
end

def days_to_check
  if Rails.env.production?
    # On Sunday, we check 5 days out (Sunday - skipped, Monday - checked, Tuesday - checked, Wednesday - checked, Thursday - checked)
    # On Thursday, we check 4 day out (Thursday - skipped, Friday - checked, Saturday - checked, Sunday - checked)
    # 5 - 1 and 4 - 1 equals 7 days to check
    Time.now.in_time_zone('Pacific Time (US & Canada)').strftime('%A') == 'Thursday' ? 4 : 5
  else
    # The max that we can check with Surfline is 5 days out
    # so that's the limiting factor
    5
  end
end
