# frozen_string_literal: true

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
      @conditions ||= self.class.get('/kbyg/regions/forecasts/conditions', options)
    end
  end
end
