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
#

class Alert < ApplicationRecord
  validates_presence_of :name
  validate :either_spot_or_subregion
  validate :not_both_spot_or_subregion

  has_one :condition, dependent: :destroy
  accepts_nested_attributes_for :condition

  private

  def either_spot_or_subregion
    return if spot_id || subregion_id

    errors.add(:subregion_id, 'Either spot ID or subregion ID')
    errors.add(:spot_id, 'Either spot ID or subregion ID')
  end

  def not_both_spot_or_subregion
    return unless spot_id && subregion_id

    errors.add(:subregion_id, 'Either spot ID or subregion ID') if spot_id
    errors.add(:spot_id, 'Either spot ID or subregion ID') if subregion_id
  end
end
