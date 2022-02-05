# frozen_string_literal: true

class AddSubregionNameToAlerts < ActiveRecord::Migration[7.0]
  def change
    add_column :alerts, :subregion_name, :string
  end
end
