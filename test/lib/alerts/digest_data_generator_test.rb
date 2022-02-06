# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

require 'alerts/digest_data_generator'
require 'alerts/sources/conditions_source'

class MockConditionsSource
  def am_min_height(day)
    conditions[day].dig('am', 'minHeight')
  end

  def am_max_height(day)
    conditions[day].dig('am', 'maxHeight')
  end

  def am_rating(day)
    conditions[day].dig('am', 'rating')
  end

  def pm_min_height(day)
    conditions[day].dig('pm', 'minHeight')
  end

  def pm_max_height(day)
    conditions[day].dig('pm', 'maxHeight')
  end

  def pm_rating(day)
    conditions[day].dig('pm', 'rating')
  end

  def load
    conditions
  end

  private

  def conditions
    @conditions ||= JSON.load_file('test/fixtures/files/conditions.json').dig('data', 'conditions')
  end
end

module Alerts
  class DigestDataGeneratorTest < ActiveSupport::TestCase
    setup do
      Timecop.freeze(Time.local(2022, 1, 20, 8, 0, 0, 8))
    end

    teardown do
      Timecop.return
    end

    test '#generate single condition' do
      mock = MockConditionsSource.new
      Alerts::ConditionsSource.stub :new, mock do
        generator = DigestDataGenerator.new(users(:dudebro).id)

        expected = [alerts(:decent_sb).id, [4, 5, 6]]
        assert_includes(generator.generate, expected)
      end
    end

    test '#generate multi conditions' do
      mock = MockConditionsSource.new
      Alerts::ConditionsSource.stub :new, mock do
        generator = DigestDataGenerator.new(users(:dudebro).id)

        expected = [alerts(:good_sb).id, [6]]
        assert_includes(generator.generate, expected)
      end
    end
  end
end
