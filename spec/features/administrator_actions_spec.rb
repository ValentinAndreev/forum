require 'rails_helper'

feature 'Administrator actions' do
  given!(:another_user) { create(:user, email: 'another_mail@mail.com') }
  given!(:post) { create(:post, name: 'CreatedPostName', text: 'Created_post_text', user: another_user) }
  given!(:another_post) { create(:post, name: 'AnotherPostName', text: 'Another_post_text', user: another_user) }
  given!(:comment) { create(:comment, post: post, text: 'First_com', user: another_user) }  
  given!(:another_comment) { create(:comment, post: post, text: 'Another', user: another_user) }    

  before do
    log_in_admin
    visit posts_path
  end
  
  scenario 'administrator can see table of posts' do
    click_on 'Table of posts'
    expect(page).to have_current_path(post_search_path)
    expect(page).to have_content('Administrators table of posts')
  end

  scenario 'administrator can see table of comments' do
    click_on 'Table of comments'
    expect(page).to have_current_path(comment_search_path)
    expect(page).to have_content('Administrators table of comments')
  end

  scenario 'search post by name' do 
    click_on 'Table of posts'     
    fill_in 'Name contains', with: 'AnotherPost'
    click_on 'Search'
    expect(page).to_not have_content 'CreatedPost'
  end    

  scenario 'search post by text' do
    click_on 'Table of posts'
    fill_in 'Text contains', with: 'Another_post'
    click_on 'Search'
    expect(page).to_not have_content 'Created_post'   
  end

  scenario 'search comment by text' do
    click_on 'Table of comments'
    fill_in 'Text contains', with: 'First_com'
    click_on 'Search'
    expect(page).to_not have_content 'Another'   
  end

  scenario 'show post from posts table' do
    click_on 'Table of posts'
    click_on 'CreatedPostName'
    expect(page).to have_content 'Author: another_mail@mail.com'
    expect(page).to have_content 'New comment'    
  end

  scenario 'delete posts of another users from posts table' do
    click_on 'Delete', match: :first
    expect(page).to_not have_content 'Created_post_name'
  end

  scenario 'show post from comments table' do
    click_on 'Table of comments'
    click_on 'CreatedPostName', match: :first
    expect(page).to have_content 'Author: another_mail@mail.com'
    expect(page).to have_content 'New comment'    
  end

  scenario 'delete posts of another users from comment table' do
    click_on 'Table of comments'
    click_on 'Delete', match: :first
    expect(page).to_not have_content 'Created_post_name'
  end
end