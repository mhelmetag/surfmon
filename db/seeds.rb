# frozen_string_literal: true

users = [{ email: 'dudebro@example.com' }, { email: 'surfchick@example.com' }]

alerts = [
  {
    name: 'Decent SB',
    subregion_id: '58581a836630e24c44878fd4',
    condition_attributes: {
      source: 'conditions',
      field: 'am_min_height',
      comparator: 'gt',
      value: '3'
    }
  },
  {
    name: 'Good ventucky',
    subregion_id: '58581a836630e24c4487900c',
    condition_attributes: {
      source: 'conditions',
      field: 'am_rating',
      comparator: 'gt',
      value: 'FAIR'
    }
  }
]

users.each do |user|
  user = User.create!(user)

  alerts.each { |alert| Alert.create!(alert.merge(user:)) }
end
