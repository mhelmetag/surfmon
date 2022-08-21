# frozen_string_literal: true

class BackfillSubregionNameOnAlerts < ActiveRecord::Migration[7.0]
  def up
    Alert.all.each { |a| a.update(subregion_name: 'Unknown') }
  end
end
