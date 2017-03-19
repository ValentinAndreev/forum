require 'rails_helper'

feature 'Users creation and login' do
  given!(:user) { create(:user) }

  scenario 'sign up' do
    visit new_user_path
    fill_in 'Email', with: 'test_mail@mail.com'
    fill_in 'Password', with: 'password', match: :prefer_exact
    fill_in 'Password confirmation', with: 'password', match: :prefer_exact
    click_on 'Create user'
    expect(page).to have_content 'Succesfully registered'
  end

  scenario 'user login with wrong credentials' do
    visit login_path
    fill_in 'Email', with: 'mail@mail.com'
    fill_in 'Password', with: 'wrong_password'
    click_on 'Login'
    expect(page).to have_content "Can't login"
  end

  scenario 'user log in and logout' do
    log_in_user
    click_on 'Logout', match: :first
    expect(page).to have_content 'You must register or login to continue.'
  end
end