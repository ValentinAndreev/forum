require 'rails_helper'

feature 'Another users post actions' do
  given!(:user) { create(:user) }
  given!(:another_user) { create(:user, email: 'another_mail@mail.com') }
  given!(:post) { create(:post, name: 'Post name', text: 'Post text', user: another_user) }

  background { log_in_user }

  scenario "can't edit post" do
    expect(page).to_not have_button 'Edit'
  end

  scenario 'can show post' do
    visit root_path
    click_on 'All posts', match: :first
    click_on 'Show'
    expect(page).to have_content 'Author: another_mail@mail.com'
    expect(page).to have_content 'Post text'    
  end

  scenario "can't delete post" do
    expect(page).to_not have_button 'Delete'
  end
end