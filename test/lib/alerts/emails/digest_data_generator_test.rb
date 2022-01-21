# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

require 'alerts/emails/digest_data_generator'
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

  private

  def conditions
    @conditions ||= JSON.load_file('test/fixtures/files/conditions.json').dig('data', 'conditions')
  end
end

module Alerts
  module Emails
    class DigestDataGeneratorTest < ActiveSupport::TestCase
      setup do
        Timecop.freeze(Time.local(2022, 1, 20, 8, 0, 0, 8))
      end

      teardown do
        Timecop.return
      end

      test '#generate' do
        mock = MockConditionsSource.new
        Alerts::ConditionsSource.stub :new, mock do
          generator = DigestDataGenerator.new

          expected = [[users(:dudebro).id, [[alerts(:decent_sb).id, [6]]]]]
          assert_equal(expected, generator.generate)
        end
      end
    end
  end
end
