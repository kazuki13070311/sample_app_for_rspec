module LoginModule
  def login(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end

  # def login_failure_email(user)
  #   visit login_path
  #   fill_in 'email', with: nil
  #   fill_in 'password', with: 'password'
  #   click_button 'Login'
  # end

  # def login_failure_email_registered(user)
  #   visit login_path
  #   fill_in 'email', with: user.email
  #   fill_in 'password', with: 'password'
  #   click_button 'Login'
  # end
end