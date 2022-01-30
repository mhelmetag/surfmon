# frozen_string_literal: true

module ConditionsHelper
  def sources_for_select
    @alerts_configuration.sources.map { |source| [I18n.t(['configuration', 'sources', source, 'name'].join('.')), source] }
  end

  def fields_for_select(source)
    @alerts_configuration.source_fields(source).map do |field|
      [I18n.t(['configuration', 'sources', source, 'fields', field, 'name'].join('.')), field]
    end
  end

  def comparators_for_select
    Condition::COMPARATORS.map { |c| [I18n.t(c, scope: 'conditions.comparators'), c] }
  end

  def values_for_select(source, field)
    @alerts_configuration.field_values(source, field).map do |value|
      [I18n.t(['configuration', 'sources', 'conditions', 'fields', field, 'values', value].join('.')), value]
    end
  end
end
