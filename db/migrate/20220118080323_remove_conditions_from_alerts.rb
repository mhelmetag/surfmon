# frozen_string_literal: true

class RemoveConditionsFromAlerts < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      remove_column :alerts, :conditions, :jsonb
    end
  end
end
