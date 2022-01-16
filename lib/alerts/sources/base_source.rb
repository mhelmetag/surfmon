# frozen_string_literal: true

module Alerts
  class BaseSource
    include HTTParty
    base_uri 'services.surfline.com'

    def initialize(region_id: nil, spot_id: nil)
      raise ArgumentError, 'Must set region_id or spot_id' unless region_id || spot_id

      @region_id = region_id
      @spot_id = spot_id
    end

    private

    def options
      { query: locations_params.merge(days: 6) }
    end

    def location_params
      if @region_id
        { regionId: @region_id }
      else
        { spotId: @spot_id }
      end
    end
  end
end
