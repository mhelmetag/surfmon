# frozen_string_literal: true

require 'alerts/providers/surfline_provider'

module Alerts
  class SurflineSpotSearcher
    def search(query)
      response = Alerts::SurflineSpotProvider.new.search(query)
      return [['Error! Does not compute!', '']] unless response.code == 200

      spot_response = response.parsed_response[0]
      spot_hits = spot_response.dig('hits', 'hits') || []
      spot_hits.map do |spot_hit|
        name = spot_hit.dig('_source', 'name')
        id = spot_hit.dig('_source', 'href').split('/')[5] # https://www.surfline.com/surf-report/sandspit/5842041f4e65fad6a7708966

        [name, id]
      end
    end
  end
end
