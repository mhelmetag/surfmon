# frozen_string_literal: true

class AddNotNullOnProviderColumns < ActiveRecord::Migration[7.0]
  def change
    # small table
    safety_assured do
      change_column_null :alerts, :provider_search_id, false
      change_column_null :alerts, :provider_search_name, false
    end
  end
end
