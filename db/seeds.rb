# frozen_string_literal: true

user = { email: 'dudebro@example.com' }

user = User.create!(user)

alerts = [
  {
    name: 'Decent SB',
    subregion_id: '58581a836630e24c44878fd4',
    condition_attributes: {
      source: 'conditions',
      field: 'am_min_height',
      comparator: 'gt',
      value: '3'
    },
    user_id: user.id
  },
  {
    name: 'Good ventucky',
    subregion_id: '58581a836630e24c4487900c',
    condition_attributes: {
      source: 'conditions',
      field: 'am_rating',
      comparator: 'gt',
      value: 'FAIR'
    },
    user_id: user.id
  }
]

alerts.each { |alert| Alert.create!(alert) }
