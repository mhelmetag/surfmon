# frozen_string_literal: true

require 'alerts/configuration'

Dir[Rails.root.join('lib/alerts/sources/**/*.rb')].each { |file| require file }
Dir[Rails.root.join('lib/alerts/searchers/**/*.rb')].each { |file| require file }

module Alerts
  class DigestDataGenerator
    def initialize(user_id, days_to_check = 5)
      @user = User.find(user_id)
      @days_to_check = days_to_check
      @configuration = Alerts::Configuration.new
    end

    def generate
      alerts = user.alerts.preload(:conditions)

      filtered_alert_ids_and_days_of_week(alerts)
    end

    private

    attr_reader :user, :days_to_check, :configuration

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
      binding.irb if alert.id == 7

      source_cache = build_source_cache(alert)

      days_of_week = []

      days_to_check.times do |day| # TODO: Make this configurable
        next if day.zero? # Skip today

        is_matching_day = alert.conditions.reduce(true) do |previous, condition|
          day_value = source_cache[condition.source].public_send(condition.field, day)
          converted_day_value = convert_value(alert, condition, day_value)

          if converted_day_value.present?
            previous && comparison_lambda(alert, condition).call(converted_day_value)
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
        source_klass = configuration.source_klass(alert.provider_type, source_name)
        source = source_klass.new(alert.provider_search_id)
        source.load
        cache[source_name] = source

        cache
      end
    end

    def comparison_lambda(alert, condition)
      converted_condition_value = convert_value(alert, condition, condition.value)

      case condition.comparator
      when 'eq'
        ->(converted_day_value) { converted_day_value == converted_condition_value }
      when 'gt'
        ->(converted_day_value) { converted_day_value > converted_condition_value }
      when 'lt'
        ->(converted_day_value) { converted_day_value < converted_condition_value }
      end
    end

    def convert_value(alert, condition, value)
      field_type = configuration.field_type(alert.provider_type, condition.source, condition.field)

      case field_type
      when 'OrderedList'
        field_values = configuration.field_values(alert.provider_type, condition.source, condition.field)

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
