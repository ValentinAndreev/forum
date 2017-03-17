require 'rails_helper'

feature 'Another users post actions' do
  before do 
    log_in_user 
    visit post_path(Post.first)
  end

  given!(:another_user) { create(:user, email: 'another_mail@mail.com') }
  given!(:comment) { create(:comment, text: 'another comment text', user: another_user, post: Post.first) }

  scenario "can't edit comment" do
    expect(page).to_not have_button 'Edit'
  end

  scenario "can't delete comment" do
    expect(page).to_not have_button 'Delete'
  end
end