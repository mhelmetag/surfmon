# frozen_string_literal: true

module Alerts
  class BaseSource
    def initialize(region_id: nil, spot_id: nil)
      raise ArgumentError, 'Must set region_id or spot_id' unless region_id || spot_id

      @region_id = region_id
      @spot_id = spot_id
    end
  end
end
