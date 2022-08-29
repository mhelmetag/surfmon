# frozen_string_literal: true

users = [{ email: 'dudebro@example.com' }, { email: 'surfchick@example.com' }]

alerts = [
  {
    name: 'Decent SB',
    provider_search_name: 'Rincon',
    provider_search_id: '5842041f4e65fad6a7708814',
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
    provider_search_name: 'Ventura Point',
    provider_search_id: '584204204e65fad6a77096b1',
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
    provider_search_name: 'Rincon',
    provider_search_id: '5842041f4e65fad6a7708814',
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
