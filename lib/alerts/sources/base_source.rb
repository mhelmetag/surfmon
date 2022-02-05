# frozen_string_literal: true

module Alerts
  module Sources
    class SourceError < StandardError; end

    class BaseSource
      def initialize(subregion_id)
        @subregion_id = subregion_id
      end

      def load
        raise NotImplementedError, '#load must be implemented'
      end

      private

      attr_reader :subregion_id
    end
  end
end
