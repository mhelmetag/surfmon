# frozen_string_literal: true

class RemoveSpotIdFromAlerts < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      remove_column :alerts, :spot_id, :string
    end
  end
end
