# frozen_string_literal: true

require 'alerts/sources/base_source'

module Alerts
  module Sources
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

      private

      def conditions
        @conditions ||= begin
          response = HTTParty.get('https://services.surfline.com/kbyg/regions/forecasts/conditions', options)
          raise Alerts::Sources::SourceError, 'Received a non-200 code from surfline' unless response.code == 200

          response.parsed_response.dig('data', 'conditions')
        end
      end

      def options
        { query: { subregionId: subregion_id, days: 8 }, headers: headers }
      end

      def headers
        {
          Accept: 'application/json',
          # rubocop:disable Layout/LineLength
          'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36'
          # rubocop:enable Layout/LineLength
        }
      end
    end
  end
end
