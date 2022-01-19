class AddSpotIdAndSubregionIdToAlerts < ActiveRecord::Migration[7.0]
  def change
    add_column :alerts, :spot_id, :string
    add_column :alerts, :subregion_id, :string
  end
end
