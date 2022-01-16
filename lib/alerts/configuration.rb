# frozen_string_literal: true

module Alerts
  class Configuration
    def sources
      configuration['sources'].keys
    end

    def source_class(source)
      configuration.dig('sources', source, 'class')
    end

    def source_attributes(source)
      configuration.dig('sources', source, 'attributes').keys
    end

    private

    def configuration
      @configuration ||= YAML.safe_load(File.read(File.join(Rails.root, 'config/alerts.yml')))
    end
  end
end
