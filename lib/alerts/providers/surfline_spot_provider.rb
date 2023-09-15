# frozen_string_literal: true

module Alerts
  class SurflineSpotProvider
    include HTTParty
    base_uri 'https://services.surfline.com'

    def search(query)
      options = { query: { q: query, querySize: 10, suggestionSize: 1, newsSearch: false }, headers: headers }

      self.class.get('/search/site', options)
    end

    def conditions(spot_id)
      options = { query: { spotId: spot_id, days: 5 }, headers: headers }

      self.class.get('/kbyg/regions/forecasts/conditions', options)
    end

    def wave(spot_id)
      options = { query: { spotId: spot_id, days: 5 }, headers: headers }

      self.class.get('/kbyg/regions/forecasts/wave', options)
    end

    private

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
