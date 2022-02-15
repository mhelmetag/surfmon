# frozen_string_literal: true

require 'alerts/sources/base_source'
require 'alerts/providers/surfline_provider'

module Alerts
  class ConditionsSource < BaseSource
    def am_min_height(day)
      conditions.dig(day, 'am', 'minHeight')
    end

    def am_max_height(day)
      conditions.dig(day, 'am', 'maxHeight')
    end

    def am_rating(day)
      conditions.dig(day, 'am', 'rating')
    end

    def pm_min_height(day)
      conditions.dig(day, 'pm', 'minHeight')
    end

    def pm_max_height(day)
      conditions.dig(day, 'pm', 'maxHeight')
    end

    def pm_rating(day)
      conditions.dig(day, 'pm', 'rating')
    end

    def load
      conditions
    end

    private

    def conditions
      @conditions ||= begin
        response = SurflineProvider.new.conditions(subregion_id)
        raise Alerts::SourceError, 'Received a non-200 code from surfline' unless response.code == 200

        response.parsed_response.dig('data', 'conditions')
      end
    end
  end
end
