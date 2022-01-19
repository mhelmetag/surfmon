# frozen_string_literal: true

class CreateConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :conditions do |t|
      t.string :source, null: false
      t.string :field, null: false
      t.string :comparator, null: false
      t.string :value, null: false

      t.references :alert, null: false

      t.timestamps
    end
  end
end
