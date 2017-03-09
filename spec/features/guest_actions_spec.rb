require 'rails_helper'

feature 'Guests actions' do
  background { visit root_path }

  scenario 'guest must see invitation to registration' do
    expect(page).to have_content 'You must register or login to continue.'
  end

  scenario 'guest can register' do
    click_on 'Registration'
    expect(page).to have_current_path(new_user_path)
  end

  scenario 'guest can log in' do
    click_on 'Sign in'
    expect(page).to have_current_path(login_path)
  end
end