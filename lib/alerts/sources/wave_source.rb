# frozen_string_literal: true

require 'alerts/sources/base_source'

module Alerts
  module Sources
    class WaveSource < BaseSource
      def direction(day)
        wave.dig(day, 'swells', 0, 'direction')
      end

      def height(day)
        wave.dig(day, 'swells', 0, 'height')
      end

      def period(day)
        wave.dig(day, 'swells', 0, 'period')
      end

      def load
        wave
      end

      private

      def wave
        @wave ||= begin
          response = HTTParty.get('https://services.surfline.com/kbyg/regions/forecasts/wave', options)
          raise Alerts::Sources::SourceError, 'Received a non-200 code from surfline' unless response.code == 200

          response.parsed_response.dig('data', 'wave')
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
