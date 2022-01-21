# frozen_string_literal: true

# == Schema Information
#
# Table name: alerts
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  spot_id      :string
#  subregion_id :string
#  user_id      :integer          not null
#
# Indexes
#
#  index_alerts_on_user_id  (user_id)
#

class Alert < ApplicationRecord
  validates_presence_of :name
  validate :spot_or_subregion

  strip_attributes

  belongs_to :user

  has_one :condition, dependent: :destroy
  accepts_nested_attributes_for :condition

  private

  def spot_or_subregion
    return if spot_id.present? || subregion_id.present? # either
    return if spot_id.present? && subregion_id.present? # not both

    errors.add(:base, :spot_or_subregion, message: 'Spot ID or subregion ID must be present but not both')
  end
end
