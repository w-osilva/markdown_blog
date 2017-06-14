require 'rails_helper'

RSpec.describe "Post", :type => :integracao do

    describe "the signin process", :type => :feature do

      it "signs me in" do
        user_email = 'user@example.com'
        user_password = 'mysecretpassword'
        user = FactoryGirl.create(:user, {email: user_email, password: user_password})
        visit '/login'
        within("#new_user") do
          fill_in 'Email', with: user_email
          fill_in 'Password', with: user_password
        end

        click_button 'Enter'
        expect(page).to have_content 'Signed in successfully.'

        find("h1", :text => "Post")

        find("table", :class => "table")
        
        find("a", :text => "New Post").click

        expect(page).to have_content 'New Post'

        expect(page).to have_content 'Title'
        expect(page).to have_content 'Text md'

        fill_in 'Title', with: 'my title of post capybara test'
        fill_in 'Text md', with: "# H1 \n ## H2 \n ### H3 \n #### H4 \n ##### H5 \n ###### H6"

        click_button("Create Post")

        expect(page).to have_content 'Post was successfully created.'
        expect(page).to have_content 'Original:'
        expect(page).to have_content 'Blog:'
      end

    end
end