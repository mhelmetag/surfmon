# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'sign up' do
    visit root_path

    click_on 'Sign Up'

    fill_in 'user[email]', with: 'surfergirl@example.com'
    fill_in 'challenge', with: 'Kelly Slater'
    click_on 'Create User'

    assert_current_path alerts_path
  end
end
