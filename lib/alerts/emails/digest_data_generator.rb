# frozen_string_literal: true

require 'alerts/configuration'
Dir['alerts/sources/*.rb'].each { |file| require file }

require 'minitest/autorun'

module Alerts
  module Emails
    class DigestDataGenerator
      def initialize
        @configuration = Alerts::Configuration.new
      end

      def generate
        User.all.map do |user|
          alerts = user.alerts.preload(:condition)

          alert_ids_and_days_of_week = alerts.map do |alert|
            days_of_week = resolve_condition(alert) || []

            [alert.id, days_of_week]
          end

          [user.id, alert_ids_and_days_of_week]
        end
      end

      private

      attr_reader :configuration

      def resolve_condition(alert)
        condition = alert.condition
        source_class = configuration.source_klass(condition.source).constantize
        source = source_class.new(subregion_id: alert.subregion_id, spot_id: alert.spot_id)

        days_of_week = []

        # skip 0 since that's Sun
        (1..7).each do |day|
          day_value = source.public_send(condition.field, day)
          converted_day_value = convert_value(condition, day_value)

          days_of_week << day if comparison_lambda(condition).call(converted_day_value)
        end

        days_of_week
      end

      def comparison_lambda(condition)
        converted_condition_value = convert_value(condition, condition.value)

        case condition.comparator
        when 'eq'
          ->(converted_day_value) { converted_day_value == converted_condition_value }
        when 'gt'
          ->(converted_day_value) { converted_day_value > converted_condition_value }
        when 'lt'
          ->(converted_day_value) { converted_day_value < converted_condition_value }
        end
      end

      def convert_value(condition, value)
        attribute_type = configuration.attribute_type(condition.source, condition.field)

        case attribute_type
        when 'String'
          attribute_values = configuration.attribute_values(condition.source, condition.field)

          attribute_values.find_index(value)
        when 'Integer'
          value.to_i
        else
          value
        end
      end
    end
  end
end
