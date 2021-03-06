# frozen_string_literal: true

users = [{ email: 'dudebro@example.com' }, { email: 'surfchick@example.com' }]

alerts = [
  {
    name: 'Decent SB',
    subregion_name: 'Santa Barbara',
    subregion_id: '58581a836630e24c44878fd4',
    conditions_attributes: [
      {
        source: 'conditions',
        field: 'am_rating',
        comparator: 'gt',
        value: 'FAIR'
      },
      {
        source: 'conditions',
        field: 'am_min_height',
        comparator: 'gt',
        value: '3'
      }
    ]
  },
  {
    name: 'Good ventucky',
    subregion_name: 'Ventura',
    subregion_id: '58581a836630e24c4487900c',
    conditions_attributes: [
      {
        source: 'conditions',
        field: 'am_rating',
        comparator: 'gt',
        value: 'FAIR'
      }
    ]
  },
  {
    name: 'Complexly good SB',
    subregion_name: 'Santa Barbara',
    subregion_id: '58581a836630e24c44878fd4',
    conditions_attributes: [
      {
        source: 'wave',
        field: 'direction',
        comparator: 'gt',
        value: '29'
      },
      {
        source: 'wave',
        field: 'direction',
        comparator: 'lt',
        value: '101'
      },
      {
        source: 'wave',
        field: 'height',
        comparator: 'gt',
        value: '1.3'
      },
      {
        source: 'wave',
        field: 'period',
        comparator: 'gt',
        value: '2'
      }
    ]
  }
]

users.each do |user|
  user = User.create!(user)

  alerts.each { |alert| Alert.create!(alert.merge(user: user)) }
end
