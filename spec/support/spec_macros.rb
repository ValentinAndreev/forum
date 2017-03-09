module SpecMacros
  def log_in_user
    user = create(:user)
    visit login_path
    fill_in 'Email', with: 'mail@mail.com'
    fill_in 'Password', with: 'password'
    click_on 'Login'
    expect(page).to have_content 'Succesfully logined'
  end
end