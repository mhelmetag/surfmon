# frozen_string_literal: true

# == Schema Information
#
# Table name: alerts
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  subregion_id   :string           not null
#  user_id        :integer          not null
#  subregion_name :string           not null
#
# Indexes
#
#  index_alerts_on_user_id  (user_id)
#

class Alert < ApplicationRecord
  validates_presence_of :name, :subregion_id, :subregion_name

  strip_attributes

  belongs_to :user
  has_many :conditions, dependent: :destroy
  accepts_nested_attributes_for :conditions, allow_destroy: true
end
