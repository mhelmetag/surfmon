# frozen_string_literal: true

module ConditionsHelper
  def sources_for_select(alerts_configuration, provider_type)
    alerts_configuration.sources(provider_type).map do |source|
      [I18n.t(['configuration', provider_type, 'sources', source, 'name'].join('.')), source]
    end
  end

  def fields_for_select(alerts_configuration, provider_type, source)
    alerts_configuration.source_fields(provider_type, source).map do |field|
      [I18n.t(['configuration', provider_type, 'sources', source, 'fields', field, 'name'].join('.')), field]
    end
  end

  def comparators_for_select
    Condition::COMPARATORS.map { |c| [I18n.t(c, scope: 'conditions.comparators'), c] }
  end

  def values_for_select(alerts_configuration, provider_type, source, field)
    alerts_configuration.field_values(provider_type, source, field).map do |value|
      [I18n.t(['configuration', provider_type, 'sources', 'conditions', 'fields', field, 'values', value].join('.')), value]
    end
  end
end
