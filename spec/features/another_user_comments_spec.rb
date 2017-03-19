require 'rails_helper'

feature 'Another users post actions' do
  given!(:user) { create(:user) }
  given!(:another_user) { create(:user, email: 'another_mail@mail.com') }
  given!(:post) { create(:post, user: user) }
  given!(:comment) { create(:comment, text: 'another comment text', user: another_user, post: post) }

  before do 
    log_in_user
    visit post_path(post)
  end

  scenario "can't edit comment" do
    expect(page).to_not have_button 'Edit'
  end

  scenario "can't delete comment" do
    expect(page).to_not have_button 'Delete'
  end
end