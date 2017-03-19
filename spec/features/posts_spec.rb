require 'rails_helper'

feature 'Posts actions' do
  given!(:user) { create(:user) }
  given!(:post) { create(:post, user: user) }
  
  before do 
    log_in_user(user)
    visit posts_path
  end
  
  scenario 'create post', js: true do
    click_on 'New post'    
    fill_in 'Name', with: 'Post name'
    fill_in "Text", with: 'Post name'
    click_on 'Create Post'
    expect(page).to have_selector('#form', visible: false)
    expect(page).to have_content 'Post name'
  end    

  scenario 'edit post', js: true do
    click_on 'Show'
    click_on 'Edit'
    fill_in 'Name', with: 'New name' 
    fill_in "Text", with: 'New text'
    click_on 'Update Post'
    expect(page).to have_selector('#form', visible: false)
    expect(page).to have_content 'New text'
    expect(page).to have_content 'New name'
  end

  scenario 'show post' do
    click_on 'Show'  
    expect(current_path).to eq post_path(1)
    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'    
  end

  scenario 'delete posts', js: true do
    click_on 'Delete' 
    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content 'Post name'
  end
end