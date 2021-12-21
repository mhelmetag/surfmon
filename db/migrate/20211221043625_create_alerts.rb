# frozen_string_literal: true

class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts do |t|
      t.string :name
      t.jsonb :conditions

      t.timestamps
    end
  end
end
