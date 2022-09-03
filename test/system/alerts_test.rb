# frozen_string_literal: true

require 'application_system_test_case'

class AlertsTest < ApplicationSystemTestCase
  test 'create surfline alert' do
    passwordless_sign_in(users(:dudebro))

    visit alerts_path

    click_on 'New Surfline Alert'

    fill_in 'alert[name]', with: 'Test Alert'

    click_on 'Search'

    within '.modal-content' do
      fill_in 'search', with: 'Ja'

      sleep(0.50) # wait for debounce/turbo

      select 'Jalama', from: 'provider_search_select'
      click_on 'Update'
    end

    fill_in 'alert[conditions_attributes][0][value]', with: '2'

    click_on 'Create Alert'

    assert_current_path alerts_path
  end

  test 'change surfline alert source' do
    passwordless_sign_in(users(:dudebro))

    visit edit_alert_path(alerts(:good_sb))

    sleep(0.25) # wait for turbo

    select 'Wave', from: 'alert[conditions_attributes][1][source]'
    assert_text 'Direction'
  end

  test 'change surfline alert field' do
    passwordless_sign_in(users(:dudebro))

    visit edit_alert_path(alerts(:good_sb))

    sleep(0.25) # wait for turbo

    select 'AM Rating', from: 'alert[conditions_attributes][1][field]'
    assert_text 'Fair to Good'
  end

  test 'add condition to surfline alert' do
    passwordless_sign_in(users(:dudebro))

    visit edit_alert_path(alerts(:good_sb))

    sleep(0.25) # wait for turbo

    click_on 'Add Condition'
    select 'PM Rating', from: 'alert[conditions_attributes][2][field]'
    select 'Good', from: 'alert[conditions_attributes][2][value]'

    click_on 'Update Alert'

    assert_current_path alerts_path
  end
end
