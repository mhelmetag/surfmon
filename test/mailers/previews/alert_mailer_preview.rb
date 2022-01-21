# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/alert_mailer
class AlertMailerPreview < ActionMailer::Preview
  def digest
    user_id = User.first.id
    alert_ids_and_days_of_week = [[Alert.first.id, [1, 2, 3]], [Alert.second.id, [4, 6]]]
    AlertMailer.digest(user_id, alert_ids_and_days_of_week)
  end
end
