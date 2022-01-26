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
  validate :valid_field
  validate :valid_value
  validates :comparator, inclusion: { in: COMPARATORS }

  strip_attributes

  belongs_to :alert

  def to_s
    [source, field, comparator, value].join(' ')
  end

  private

  def valid_field
    source_fields = configuration.source_fields(source)

    errors.add(:field, 'is an unknown value') unless source_fields.present?
    errors.add(:field, 'is not included in the list') if source_fields.present? && !source_fields&.include?(field)
  end

  def valid_value
    field_type = configuration.field_type(source, field)

    case field_type
    when 'OrderedList'
      valid_ordered_list
    when 'Integer'
      valid_integer
    else
      errors.add(:value, 'is an unknown value')
    end
  end

  def valid_ordered_list
    field_values = configuration&.field_values(source, field)

    errors.add(:value, 'is not included in the list') unless field_values&.include?(value)
  end

  def valid_integer
    Integer(value)
  rescue ArgumentError
    errors.add(:value, 'must be an integer')
  end

  def configuration
    @configuration ||= Alerts::Configuration.new
  end
end
