# frozen_string_literal: true

require 'alerts/sources/base_source'

module Alerts
  class ConditionsSource < BaseSource
    def am_min_height(day)
      conditions[day].dig('am', 'minHeight')
    end

    def am_max_height(day)
      conditions[day].dig('am', 'maxHeight')
    end

    def am_rating(day)
      conditions[day].dig('am', 'rating')
    end

    def pm_min_height(day)
      conditions[day].dig('pm', 'minHeight')
    end

    def pm_max_height(day)
      conditions[day].dig('pm', 'maxHeight')
    end

    def pm_rating(day)
      conditions[day].dig('pm', 'rating')
    end

    private

    def conditions
      @conditions ||= begin
        response = self.class.get('/kbyg/regions/forecasts/conditions', options)
        raise Alerts::SourceError, 'Received a non-200 code from surfline' unless response.code == 200

        response.parsed_response.dig('data', 'conditions')
      end
    end
  end
end
