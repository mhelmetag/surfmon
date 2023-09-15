# frozen_string_literal: true

require 'alerts/sources/base_source'

module Alerts
  module Cdip
    class SwellSource < BaseSource
      def direction(day)
        swell.dig(day, :direction)
      end

      def height(day)
        swell.dig(day, :height)
      end

      def period(day)
        swell.dig(day, :period)
      end

      def load
        swell
      end

      private

      def swell
        @swell ||= readings.each_slice(5).map do |sliced_readings|
          {
            direction: average(items_at_csv_index(sliced_readings, 4)).to_i,
            height: meters_to_feet(average(items_at_csv_index(sliced_readings, 5))).round(2),
            period: average(items_at_csv_index(sliced_readings, 6)).to_i
          }
        end
      end

      def readings
        # an array of arrays (days x columns)
        # direction is [4]
        # height is [5] (meters)
        # period is [6]

        uri = URI.parse("https://thredds.cdip.ucsd.edu/thredds/ncss/cdip/model/MOP_alongshore/VE#{provider_search_id}_ecmwf_fc.nc")
        uri.query = URI.encode_www_form(
          {
            req: 'station',
            var: %w[waveDp waveHs waveTp],
            time_start: Time.now.utc,
            time_end: Time.now.utc + 5.days,
            accept: 'csv'
          }
        )
        data = HTTParty.get(uri.to_s).body

        data.split("\n")[1..].to_a
      end

      def items_at_csv_index(array, index)
        array.map { |i| i.split(',')[index] }
      end

      def average(items)
        items.map(&:to_d).sum / items.size
      end

      def meters_to_feet(meters)
        meters * 3.280839895
      end
    end
  end
end
