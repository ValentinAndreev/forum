module SpecMacros
  def log_in_user
    visit login_path
    fill_in 'Email', with: 'mail@mail.com'
    fill_in 'Password', with: 'password'
    click_on 'Login'
    expect(page).to have_content 'Succesfully logined'
  end

  def log_in_admin
    create(:user, email: 'admin@mail.com', admin: true)
    visit login_path
    fill_in 'Email', with: 'admin@mail.com'
    fill_in 'Password', with: 'password'
    click_on 'Login'
    expect(page).to have_content 'Succesfully logined'
  end
end
