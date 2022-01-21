# frozen_string_literal: true

class AlertMailer < ApplicationMailer
  def digest(user_id, alert_ids_and_days_of_week)
    @user = User.find(user_id)
    @alert_names_and_days_of_week = alert_ids_and_days_of_week.map do |alert_id, days_of_week|
      alert = Alert.find(alert_id)

      [alert.name, days_of_week.map { |n| n.days.from_now.strftime('%A') }.join(', ')]
    end
    mail(to: @user.email, subject: 'Surfmon weekly surf alerts')
  end
end
