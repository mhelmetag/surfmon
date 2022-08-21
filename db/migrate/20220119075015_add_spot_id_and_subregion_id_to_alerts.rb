# frozen_string_literal: true

class AddSpotIdAndSubregionIdToAlerts < ActiveRecord::Migration[7.0]
  def change
    change_table :alerts, bulk: true do |t|
      t.string :spot_id
      t.string :subregion_id
    end
  end
end
