require 'rails_helper'

feature 'Administrator actions' do
  given!(:another_user) { FactoryGirl.create(:user, email: 'another_mail@mail.com') }
  given!(:post) { FactoryGirl.create(:post, name: 'CreatedPostName', text: 'Created_post_text', user: another_user) }
  given!(:another_post) { FactoryGirl.create(:post, name: 'AnotherPostName', text: 'Another_post_text', user: another_user) }

  before do
    log_in_admin
    visit posts_path
  end
  
  scenario 'administrator can see table of posts' do
    expect(page).to have_css('.field')
    expect(page).to have_css('table#posts')    
    expect(page).to have_content('Administrators table of posts')
  end

  scenario 'search by name' do      
    fill_in 'Name contains', with: 'AnotherPost'
    click_on 'Search'
    expect(page).to_not have_content 'CreatedPost'
  end    

  scenario 'search by text' do
    fill_in 'Text contains', with: 'Another_post'
    click_on 'Search'
    expect(page).to_not have_content 'Created_post'   
  end

  scenario 'show post' do
    click_on 'CreatedPostName'
    expect(page).to have_content 'Author: another_mail@mail.com'
    expect(page).to have_content 'New comment'    
  end

  scenario 'delete posts of another users' do
    click_on 'Delete', match: :first
    expect(page).to_not have_content 'Created_post_name'
  end
end