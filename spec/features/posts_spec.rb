require 'rails_helper'

feature 'Posts actions' do
  background do 
    log_in_user 
    visit posts_path
  end
  
  scenario 'create post' do
    click_on 'New post'    
    fill_in 'Name', with: 'Post name'
    fill_in "texteditor", with: 'Post name'
    click_on 'Create Post'
    expect(page).to have_content 'Post name'
  end    

  scenario 'edit post', js: true do
    click_on 'Edit', exact: true, match: :first
    fill_in 'Name', with: 'New name' 
    within_frame("texteditor_ifr") do
      editor = page.find_by_id('tinymce') 
      editor.native.send_keys 'New text'
    end
    click_on 'Update Post'
    click_on 'Show'
    expect(page).to have_content 'New text'
    expect(page).to have_content 'New name'
  end

  scenario 'show post' do
    visit root_path
    click_on 'All posts'
    click_on 'Show', match: :first   
    expect(current_path).to eq post_path(1)
    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'    
  end

  scenario 'delete posts', js: true do
    click_on 'Delete', match: :first 
    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content 'Post name'
  end
end