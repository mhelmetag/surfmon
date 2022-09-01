# frozen_string_literal: true

Dir[Rails.root.join('lib/alerts/sources/*.rb')].each { |file| require file }
Dir[Rails.root.join('lib/alerts/searchers/*.rb')].each { |file| require file }

module Alerts
  class Configuration
    def search_klass(provider)
      configuration.dig(provider, 'search', 'class').constantize
    end

    def providers
      configuration.keys
    end

    def sources(provider)
      configuration.dig(provider, 'sources')&.keys || []
    end

    def source_klass(provider, source)
      configuration.dig(provider, 'sources', source, 'class').constantize
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
