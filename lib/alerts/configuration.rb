# frozen_string_literal: true

module Alerts
  class Configuration
    def sources
      configuration['sources'].keys
    end

    def source_klass(source)
      configuration.dig('sources', source, 'class')
    end

    def source_fields(source)
      configuration.dig('sources', source, 'fields')&.keys || []
    end

    def field_type(source, field)
      configuration.dig('sources', source, 'fields', field, 'type')
    end

    def field_values(source, field)
      configuration.dig('sources', source, 'fields', field, 'values') || []
    end

    private

    def configuration
      @configuration ||= YAML.safe_load(File.read(Rails.root.join('config/alerts.yml')))
    end
  end
end
