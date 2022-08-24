# frozen_string_literal: true

class AddProviderTypeSearchIdAndSearchNameToAlert < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      change_table :alerts, bulk: true do
        add_column :alerts, :provider_type, :string, null: false, default: 'surfline_spot'
        add_column :alerts, :provider_search_id, :string
        add_column :alerts, :provider_search_name, :string
      end
    end
  end
end
