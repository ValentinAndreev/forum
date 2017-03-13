require 'rails_helper'

feature 'Posts actions' do
  background do 
    log_in_user 
    visit posts_path
    click_on 'New post'    
    fill_in 'Name', with: 'Post name'
    fill_in 'Text', with: 'Post text'
    click_on 'Create Post'
    expect(page).to have_content 'Post name'
  end

  scenario 'edit post', js: true do
    click_on 'Edit'    
    fill_in 'Name', with: 'New name'
    fill_in 'Text', with: 'New text'
    click_on 'Update Post'
    expect(page).to_not have_content 'Post name'
    expect(page).to have_content 'New name'
  end

  scenario 'show post' do
    visit root_path
    click_on 'All posts'
    click_on 'Show'    
    expect(current_path).to eq post_path(1)
    expect(page).to have_content 'Post name'
    expect(page).to have_content 'Post text'    
  end

  scenario 'delete post', js: true do
    click_on 'Delete'    
    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content 'Post name'
  end
end