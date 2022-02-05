# frozen_string_literal: true

class BackfillSubregionNameOnAlerts < ActiveRecord::Migration[7.0]
  def up
    Alert.all.update_all(subregion_name: 'Unknown')
  end
end
