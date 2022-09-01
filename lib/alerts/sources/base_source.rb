# frozen_string_literal: true

module Alerts
  class SourceError < StandardError; end

  class BaseSource
    def initialize(provider_search_id)
      @provider_search_id = provider_search_id
    end

    def load
      raise NotImplementedError, '#load must be implemented'
    end

    private

    attr_reader :provider_search_id
  end
end
