# frozen_string_literal: true

require 'alerts/configuration'

module Alerts
  class ConfigurationTest < ActiveSupport::TestCase
    test '#sources' do
      assert_equal(['conditions'], Alerts::Configuration.new.sources)
    end

    test '#source_class' do
      assert_equal('ConditionsSource', Alerts::Configuration.new.source_class('conditions'))
    end

    test '#source_attributes' do
      attributes = %w[am_min_height am_max_height am_rating pm_min_height pm_max_height pm_rating]
      assert_equal(attributes, Alerts::Configuration.new.source_attributes('conditions'))
    end
  end
end
