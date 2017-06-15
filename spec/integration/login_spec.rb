require 'rails_helper'

RSpec.describe "Login", :type => :integration do

  let(:login_page) { Pages::Login.new }
  let(:user) { FactoryGirl.create(:user, {email: 'user@example.com', password: 'mysecretpassword'}) }

  describe "Sign in / Sign out", :type => :feature do

    context "As a valid user" do
      scenario "Load page with login form" do
        visit '/login'
        expect(page).to have_selector('form', id: "new_user")
      end

      scenario "Login with user data" do
        login user
        expect(page).to have_content 'Signed in successfully.'
      end

      scenario "Logout" do
        login user
        logout
        expect(page).to have_content 'Signed out successfully.'
      end
    end

  end

end
