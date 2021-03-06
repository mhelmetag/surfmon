# frozen_string_literal: true

require 'alerts/configuration'
Dir[Rails.root.join('lib/alerts/sources/*.rb')].each { |file| require file }

module Alerts
  class DigestDataGenerator
    def initialize(user_id)
      @user = User.find(user_id)
      @configuration = Alerts::Configuration.new
    end

    def generate
      alerts = user.alerts.preload(:conditions)

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
        days_of_week = resolve_conditions(alert)

        [alert.id, days_of_week]
      end
    end

    def resolve_conditions(alert)
      source_cache = build_source_cache(alert)

      days_of_week = []

      # skip 0 since that's Sun (today)
      # only 6 days since report is for 7 and
      # we're skipping 1 (technically day 0)
      (1..6).each do |day|
        is_matching_day = alert.conditions.reduce(true) do |previous, condition|
          day_value = source_cache[condition.source].public_send(condition.field, day)
          converted_day_value = convert_value(condition, day_value)

          if converted_day_value.present?
            previous && comparison_lambda(condition).call(converted_day_value)
          else
            false
          end
        end

        days_of_week << day if is_matching_day
      end

      days_of_week
    end

    def build_source_cache(alert)
      alert.conditions.pluck(:source).each_with_object({}) do |source_name, cache|
        source_class = configuration.source_klass(source_name).constantize
        source = source_class.new(alert.subregion_id)
        source.load
        cache[source_name] = source

        cache
      end
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
      field_type = configuration.field_type(condition.source, condition.field)

      case field_type
      when 'OrderedList'
        field_values = configuration.field_values(condition.source, condition.field)

        field_values.find_index(value)
      when 'Integer', 'Degree'
        value.to_i
      when 'Float'
        value.to_f
      else
        value
      end
    end
  end
end
