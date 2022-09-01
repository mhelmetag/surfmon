# frozen_string_literal: true

require 'alerts/sources/base_source'
require 'alerts/providers/surfline_provider'

module Alerts
  module Surfline
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
          response = Alerts::SurflineSpotProvider.new.wave(spot_id)
          raise Alerts::SourceError, 'Received a non-200 code from surfline' unless response.code == 200

          response.parsed_response.dig('data', 'wave')
        end
      end
    end
  end
end
