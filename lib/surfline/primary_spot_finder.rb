# frozen_string_literal: true

module Surfline
  class PrimarySpotFinder
    def initialize(subregion_id)
      @subregion_id = subregion_id
    end

    def find
      url = "https://www.surfline.com/surf-forecasts/whatever/#{@subregion_id}"
      response = HTTParty.get(url, headers: headers)
      document = Nokogiri::HTML(response.body)
      script = document.css('script#__NEXT_DATA__').first
      json = JSON.parse(script.inner_html)

      primary_spot_id = json.dig('props', 'pageProps', 'ssrReduxState', 'subregion', 'primarySpotId')
      primary_spot_name =
        json.
          dig('props', 'pageProps', 'ssrReduxState', 'subregion', 'overview', 'overview', 'data', 'spots').
          detect { |spot| spot['_id'] == primary_spot_id }.
          fetch('name')

      { id: primary_spot_id, name: primary_spot_name }
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
