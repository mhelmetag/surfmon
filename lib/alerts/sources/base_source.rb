# frozen_string_literal: true

module Alerts
  class SourceError < StandardError; end

  class BaseSource
    def initialize(subregion_id: nil, spot_id: nil)
      raise ArgumentError, 'Must set subregion_id or spot_id' unless subregion_id || spot_id

      @subregion_id = subregion_id
      @spot_id = spot_id
    end

    private

    attr_reader :subregion_id, :spot_id
  end
end
