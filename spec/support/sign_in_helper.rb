module SignInHelper
  def login(user)
    visit "/login"
    within("#new_user") do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_button 'Enter'
  end

  def logout
    find("a", class: "logout").click rescue false
  end
end