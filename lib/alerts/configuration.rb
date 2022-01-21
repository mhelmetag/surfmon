# frozen_string_literal: true

module Alerts
  class Configuration
    def sources
      configuration['sources'].keys
    end

    def source_klass(source)
      configuration.dig('sources', source, 'class')
    end

    def source_attributes(source)
      configuration.dig('sources', source, 'attributes').keys
    end

    def attribute_type(source, attribute)
      configuration.dig('sources', source, 'attributes', attribute, 'type')
    end

    def attribute_values(source, attribute)
      configuration.dig('sources', source, 'attributes', attribute, 'values')
    end

    private

    def configuration
      @configuration ||= YAML.safe_load(File.read(Rails.root.join('config/alerts.yml')))
    end
  end
end
