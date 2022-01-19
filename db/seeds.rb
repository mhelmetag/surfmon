# frozen_string_literal: true

user = { email: 'dudebro@example.com' }

user = User.create!(user)

alerts = [
  {
    name: 'Really good SB',
    spot_id: '5842041f4e65fad6a7708814',
    condition_attributes: {
      source: 'conditions',
      field: 'am_max_height',
      comparator: 'gt',
      value: '4'
    },
    user_id: user.id
  },
  {
    name: 'Overhead ventucky',
    subregion_id: '58581a836630e24c4487900c',
    condition_attributes: {
      source: 'conditions',
      field: 'am_rating',
      comparator: 'eq',
      value: 'GOOD'
    },
    user_id: user.id
  },
  {
    name: 'Sick Sunset',
    subregion_id: '5842041f4e65fad6a7708840',
    condition_attributes: {
      source: 'conditions',
      field: 'pm_max_height',
      comparator: 'gt',
      value: '5'
    },
    user_id: user.id
  }
]

alerts.each { |alert| Alert.create!(alert) }
