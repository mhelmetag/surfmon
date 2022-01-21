# frozen_string_literal: true

class AddUserReferenceToAlerts < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      add_reference :alerts, :user, index: true, null: false
    end
  end
end
