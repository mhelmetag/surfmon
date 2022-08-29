# frozen_string_literal: true

# == Schema Information
#
# Table name: alerts
#
#  id                   :bigint           not null, primary key
#  name                 :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  subregion_id         :string
#  user_id              :bigint           not null
#  subregion_name       :string
#  provider_type        :string           default("surfline_spot"), not null
#  provider_search_id   :string           not null
#  provider_search_name :string           not null
#
# Indexes
#
#  index_alerts_on_user_id  (user_id)
#

class Alert < ApplicationRecord
  validates :name, :provider_search_id, :provider_search_name, presence: true

  strip_attributes

  belongs_to :user
  has_many :conditions, dependent: :destroy
  accepts_nested_attributes_for :conditions, allow_destroy: true
end
