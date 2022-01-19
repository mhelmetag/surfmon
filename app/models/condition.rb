# frozen_string_literal: true

# == Schema Information
#
# Table name: conditions
#
#  id         :integer          not null, primary key
#  source     :string           not null
#  field      :string           not null
#  comparator :string           not null
#  value      :string           not null
#  alert_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_conditions_on_alert_id  (alert_id)
#

require 'alerts/configuration'

class Condition < ApplicationRecord
  COMPARATORS = %w[eq gt lt].freeze

  validates_presence_of :source, :field, :comparator, :value
  validates :source, inclusion: { in: Alerts::Configuration.new.sources }
  # validates :field, inclusion: { in: Alerts::Configuration.new.source_attributes(source) }
  validates :comparator, inclusion: { in: COMPARATORS }

  belongs_to :alert

  def to_s
    [source, field, comparator, value].join(' ')
  end
end
