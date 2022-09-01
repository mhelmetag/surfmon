# frozen_string_literal: true

require 'test_helper'

require 'alerts/configuration'
require 'alerts/sources/surfline/conditions_source'

module Alerts
  class ConfigurationTest < ActiveSupport::TestCase
    test '#sources' do
      assert_equal(%w[conditions wave], Alerts::Configuration.new.sources('surfline_spot'))
    end

    test '#source_klass' do
      assert_equal(Alerts::Surfline::ConditionsSource, Alerts::Configuration.new.source_klass('surfline_spot', 'conditions'))
    end

    test '#source_fields' do
      expected = %w[am_min_height am_max_height am_rating pm_min_height pm_max_height pm_rating]
      assert_equal(expected, Alerts::Configuration.new.source_fields('surfline_spot', 'conditions'))
    end

    test '#field_type' do
      assert_equal('OrderedList', Alerts::Configuration.new.field_type('surfline_spot', 'conditions', 'am_rating'))
    end

    test '#field_values' do
      expected = %w[NONE FLAT VERY_POOR POOR POOR_TO_FAIR FAIR FAIR_TO_GOOD GOOD VERY_GOOD GOOD_TO_EPIC EPIC]
      assert_equal(expected, Alerts::Configuration.new.field_values('surfline_spot', 'conditions', 'am_rating'))
    end
  end
end
