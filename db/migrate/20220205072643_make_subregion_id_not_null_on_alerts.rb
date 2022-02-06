# frozen_string_literal: true

class MakeSubregionIdNotNullOnAlerts < ActiveRecord::Migration[7.0]
  def change
    # small table
    safety_assured do
      change_column_null :alerts, :subregion_id, false
    end
  end
end
