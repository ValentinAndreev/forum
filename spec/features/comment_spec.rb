require 'rails_helper'

feature 'Comment actions' do
  given!(:user) { create(:user) }
  given!(:post) { create(:post, user: user) }

  before do 
    log_in_user(user)
    visit posts_path
    click_on 'Show'
    click_on 'New comment'
    fill_in 'Text', with: 'Comment text'
    click_on 'Create Comment'
    expect(page).to have_selector('#form-comment', visible: false)
    expect(page).to have_content 'Comment text'
  end

  scenario 'edit comment', js: true do
    visit posts_path
    click_on 'Show'
    click_on 'Edit comment'
    fill_in 'Text', with: 'New comment text'
    click_on 'Update Comment'    
    expect(page).to_not have_content 'Comment text'
    expect(page).to have_content 'New comment text'
  end

  scenario 'delete comment', js: true do
    visit posts_path
    click_on 'Show'    
    click_on 'Delete comment'    
    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content 'Comment text'
  end
end