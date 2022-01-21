# frozen_string_literal: true

module Alerts
  class SourceError < StandardError; end

  class BaseSource
    include HTTParty
    base_uri 'services.surfline.com'

    def initialize(subregion_id: nil, spot_id: nil)
      raise ArgumentError, 'Must set subregion_id or spot_id' unless subregion_id || spot_id

      @subregion_id = subregion_id
      @spot_id = spot_id
    end

    private

    attr_reader :subregion_id, :spot_id

    def options
      { query: location_params.merge(days: 8) }
    end

    def location_params
      if subregion_id.present?
        { subregionId: subregion_id }
      else
        { spotId: spot_id }
      end
    end
  end
end
