# frozen_string_literal: true

class MakeSubregionNameNotNullOnAlerts < ActiveRecord::Migration[7.0]
  def change
    # small table
    safety_assured do
      change_column_null :alerts, :subregion_name, false
    end
  end
end
