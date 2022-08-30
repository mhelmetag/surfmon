# frozen_string_literal: true

module Alerts
  class Configuration
    def providers
      configuration.keys
    end

    def sources(provider)
      configuration.dig(provider, 'sources')&.keys || []
    end

    def source_klass(provider, source)
      configuration.dig(provider, 'sources', source, 'class')
    end

    def source_fields(provider, source)
      configuration.dig(provider, 'sources', source, 'fields')&.keys || []
    end

    def field_type(provider, source, field)
      configuration.dig(provider, 'sources', source, 'fields', field, 'type')
    end

    def field_values(provider, source, field)
      configuration.dig(provider, 'sources', source, 'fields', field, 'values') || []
    end

    private

    def configuration
      @configuration ||= YAML.safe_load(File.read(Rails.root.join('config/alerts.yml')))
    end
  end
end
