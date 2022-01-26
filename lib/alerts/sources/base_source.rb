# frozen_string_literal: true

module Alerts
  module Sources
    class SourceError < StandardError; end

    class BaseSource
      def initialize(subregion_id)
        @subregion_id = subregion_id
      end

      private

      attr_reader :subregion_id
    end
  end
end
