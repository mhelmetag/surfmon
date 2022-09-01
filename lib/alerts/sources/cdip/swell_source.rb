# frozen_string_literal: true

require 'alerts/sources/base_source'

module Alerts
  module Cdip
    class SwellSource < BaseSource
      def direction(_day)
        0
      end

      def height(_day)
        0
      end

      def period(_day)
        0
      end

      def load
        swell
      end

      private

      def swell
        @swell ||= []
      end
    end
  end
end
