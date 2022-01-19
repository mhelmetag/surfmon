# frozen_string_literal: true

class MakeNameNotNullOnAlerts < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      change_column_null :alerts, :name, false
    end
  end
end
