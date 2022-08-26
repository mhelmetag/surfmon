# frozen_string_literal: true

# current alerts on prod

# 3,Santa Barbara,58581a836630e24c44878fd4
# 6,Ventura,58581a836630e24c4487900c
# 5,Ventura,58581a836630e24c4487900c
# 7,Ventura,58581a836630e24c4487900c
# 1,Santa Barbara,58581a836630e24c44878fd4
# 2,Ventura,58581a836630e24c4487900c
# 8,Ventura,58581a836630e24c4487900c

# run on dev

prod_data = "3,Santa Barbara,58581a836630e24c44878fd4
6,Ventura,58581a836630e24c4487900c
5,Ventura,58581a836630e24c4487900c
7,Ventura,58581a836630e24c4487900c
1,Santa Barbara,58581a836630e24c44878fd4
2,Ventura,58581a836630e24c4487900c
8,Ventura,58581a836630e24c4487900c".split("\n").map { |a| a.split(',') }.map do |a|
  { alert_id: a[0], alert_subregion_name: a[1],
    alert_subregion_id: a[2] }
end

prod_update_lookup = {}

require 'surfline/primary_spot_finder'

prod_data.each do |ad|
  next if prod_update_lookup.key?(ad[:alert_subregion_id])

  primary_spot = Surfline::PrimarySpotFinder.new(ad[:alert_subregion_id]).find

  prod_update_lookup[ad[:alert_subregion_id]] = { provider_search_id: primary_spot[:id], provider_search_name: primary_spot[:name] }
end

# run on prod

prod_update_lookup = {
  '58581a836630e24c44878fd4' => {
    :provider_search_id => '5842041f4e65fad6a7708814',
    :provider_search_name => 'Rincon'
  },
  '58581a836630e24c4487900c' => {
    :provider_search_id => '584204204e65fad6a77096b1',
    :provider_search_name => 'Ventura Point'
  }
}

Alert.all.each do |alert|
  provider_info = prod_update_lookup[alert.subregion_id]

  if provider_info
    alert.update!(provider_search_id: provider_info[:provider_search_id], provider_search_name: provider_info[:provider_search_name])
  end
end
