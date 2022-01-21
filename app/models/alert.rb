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
  validate :either_spot_or_subregion
  validate :not_both_spot_or_subregion

  belongs_to :user

  has_one :condition, dependent: :destroy
  accepts_nested_attributes_for :condition

  private

  def either_spot_or_subregion
    return if spot_id.present? || subregion_id.present?

    errors.add(:subregion_id, 'Either spot ID or subregion ID') if spot_id.present?
    errors.add(:spot_id, 'Either spot ID or subregion ID') if subregion_id.present?
  end

  def not_both_spot_or_subregion
    return unless spot_id.present? && subregion_id.present?

    errors.add(:subregion_id, 'Not both spot ID and subregion ID')
    errors.add(:spot_id, 'Not both spot ID and subregion ID')
  end
end
