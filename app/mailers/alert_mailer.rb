# frozen_string_literal: true

class AlertMailer < ApplicationMailer
  def digest(user_id, alert_ids_and_days_of_week)
    @user = User.find(user_id)
    @alert_names_and_days_of_week = alert_ids_and_days_of_week.map do |alert_id, days_of_week|
      alert = Alert.find(alert_id)

      [alert.name, days_of_week.map { |n| (n - 1).days.from_now.strftime('%A') }.join(', ')]
    end
    mail(to: @user.email, subject: 'Surfmon semi-weekly surf alerts 🏄')
  end

  def digest_error(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'Ouch! Surfmon bailed creating your semi-weekly surf alerts')
  end
end
