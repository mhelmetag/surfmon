# frozen_string_literal: true

class RemoveNotNullOnSubregionColumns < ActiveRecord::Migration[7.0]
  def change
    change_column_null :alerts, :subregion_id, true
    change_column_null :alerts, :subregion_name, true
  end
end
