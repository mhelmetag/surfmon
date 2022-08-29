# frozen_string_literal: true

module Alerts
  class SourceError < StandardError; end

  class BaseSource
    def initialize(spot_id)
      @spot_id = spot_id
    end

    def load
      raise NotImplementedError, '#load must be implemented'
    end

    private

    attr_reader :spot_id
  end
end
