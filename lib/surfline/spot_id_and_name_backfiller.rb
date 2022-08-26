# frozen_string_literal: true

require 'surfline/primary_spot_finder'

module Surfline
  class SpotIdAndNameBackfiller
    # 08/23/22
    # for backfilling provider_search_id and provider_search_name on
    # surfline_spot provider type alerts when alerts were only
    # meant for one provider type and were for surfline subregions
    #
    # 8/25/22
    # surfline is pretty good at blocking in heroku in some cases
    # so this doesn't work there for some reason...
    # onto some other more lame way to backfill

    def run
      alerts_to_backfill = Alert.where(provider_search_id: nil, provider_search_name: nil)

      alerts_to_backfill.each do |alert|
        primary_spot = Surfline::PrimarySpotFinder.new(alert.subregion_id).find

        # rubocop:disable Rails/Output
        puts "Primary spot found! Backfilling #{alert.subregion_name} with #{primary_spot[:name]}"
        # rubocop:enable Rails/Output

        alert.update(provider_search_id: primary_spot[:id], provider_search_name: primary_spot[:name])
      end
    end
  end
end
