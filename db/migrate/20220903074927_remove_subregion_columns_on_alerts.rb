# frozen_string_literal: true

class RemoveSubregionColumnsOnAlerts < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      change_table :alerts, bulk: true do
        remove_column :alerts, :subregion_name, :string
        remove_column :alerts, :subregion_id, :string
      end
    end
  end
end
