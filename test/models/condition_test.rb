# frozen_string_literal: true

require 'test_helper'

class ConditionTest < ActiveSupport::TestCase
  test 'correct everything' do
    condition_attributes = { alert: alerts(:good_sb), source: 'conditions', field: 'am_rating', comparator: 'gt', value: 'GOOD' }
    condition = Condition.new(condition_attributes)

    assert_equal(condition.save, true)
    assert_equal(condition.errors.count, 0)
  end

  test 'incorrect source' do
    condition_attributes = { alert: alerts(:good_sb), source: 'salad', field: 'whatever', comparator: 'gt', value: '7' }
    condition = Condition.new(condition_attributes)

    assert_equal(condition.save, false)
    assert_includes(condition.errors.full_messages, 'Source is not included in the list')
  end

  test 'incorrect field' do
    condition_attributes = { alert: alerts(:good_sb), source: 'conditions', field: 'whatever', comparator: 'gt', value: 'tubular' }
    condition = Condition.new(condition_attributes)

    assert_equal(condition.save, false)
    assert_includes(condition.errors.full_messages, 'Field is not included in the list')
  end

  test 'incorrect OrderedList value' do
    condition_attributes = { alert: alerts(:good_sb), source: 'conditions', field: 'am_rating', comparator: 'gt', value: 'TUBULAR' }
    condition = Condition.new(condition_attributes)

    assert_equal(condition.save, false)
    assert_includes(condition.errors.full_messages, 'Value is not included in the list')
  end

  test 'incorrect Integer value' do
    condition_attributes = { alert: alerts(:good_sb), source: 'conditions', field: 'am_min_height', comparator: 'gt',
                             value: 'salsa' }
    condition = Condition.new(condition_attributes)

    assert_equal(condition.save, false)
    assert_includes(condition.errors.full_messages, 'Value must be an integer')
  end
end
