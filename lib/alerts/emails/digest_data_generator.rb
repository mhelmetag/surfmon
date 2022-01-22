# frozen_string_literal: true

require 'alerts/configuration'
Dir[Rails.root.join('lib/alerts/sources/*.rb')].each { |file| require file }

module Alerts
  module Emails
    class DigestDataGenerator
      def initialize(user_id)
        @user = User.find(user_id)
        @configuration = Alerts::Configuration.new
      end

      def generate
        alerts = user.alerts.preload(:condition)

        filtered_alert_ids_and_days_of_week(alerts)
      end

      private

      attr_reader :user, :configuration

      def filtered_alert_ids_and_days_of_week(alerts)
        alert_ids_and_days_of_week(alerts).select do |_alert_id, days_of_week|
          days_of_week.any?
        end
      end

      def alert_ids_and_days_of_week(alerts)
        alerts.map do |alert|
          days_of_week = resolve_condition(alert) || []

          [alert.id, days_of_week]
        end
      end

      def resolve_condition(alert)
        condition = alert.condition
        source_class = configuration.source_klass(condition.source).constantize
        source = source_class.new(subregion_id: alert.subregion_id, spot_id: alert.spot_id)

        days_of_week = []

        # skip 0 since that's Sun
        (1..7).each do |day|
          day_value = source.public_send(condition.field, day)
          converted_day_value = convert_value(condition, day_value)

          days_of_week << day if converted_day_value.present? && comparison_lambda(condition).call(converted_day_value)
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
