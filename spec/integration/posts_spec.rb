require 'rails_helper'

RSpec.describe "Post", :type => :integration do

  let!(:users) {[
    FactoryGirl.create(:user, {email: 'user@example.com', password: 'mysecretpassword', nickname: 'user', first_name: 'user'}),
    FactoryGirl.create(:user, {email: 'admin@example.com', password: 'mysecretpassword', nickname: 'admin', first_name: 'admin'}),
  ]}
  let!(:posts) do
    posts = []
    (1..9).each {|i| posts << FactoryGirl.create(:post, user: users.sample) }
    (1..9).each {|i| posts << FactoryGirl.create(:post, :published, user: users.sample) }
    posts
  end

  let(:posts_page) { Pages::Posts.new }
  before{ posts_page.visit_page }

  describe "Listing posts", :type => :feature do

    scenario "Load page" do
      expect(page).to have_selector('h1', text: "Posts")
    end

    context "As a guest user" do
      scenario "I can only see the posts published (paginated every 5)" do
        expect(posts_page.items).to have(5).items
        posts_page.paginate_to(2)
        expect(posts_page.items).to have(4).items
      end
      scenario "I can not see the buttons to manipulate posts" do
        posts_page.items.each do |item|
          container_buttons = item.find('div', class: 'btn-toolbar')
          expect(container_buttons.text).to be_empty
        end
      end
      scenario "I can not see the button to add post" do
        expect(page).not_to have_selector('a', text: 'New Post')
      end
    end

    context "As a authenticated user" do
      subject(:user){ users[0]}
      before { login user }

      scenario "I can see the posts new and published (paginated every 5)" do
        expect(posts_page.items).to have(5).items
        posts_page.paginate_to(2)
        expect(posts_page.items).to have(5).items
        posts_page.paginate_to(3)
        expect(posts_page.items).to have(5).items
        posts_page.paginate_to(4)
        expect(posts_page.items).to have(3).items
      end
      scenario "I can only see the buttons to manipulate my posts" do
        user_posts = Post.where(user: :user)
        # We have 4 pages (18 items)
        (1..4).each do |page|
          posts_page.paginate_to(page)

          posts_page.items.each do |item|
            item_title = posts_page.item_title(item)
            matches = user_posts.select{|post| post.title == item_title }
            if matches.present?
              buttons = posts_page.item_buttons(item)
              expect(buttons.text).not_to be_empty
            end
          end
        end
      end
      scenario "I can see the button to add post" do
        expect(page).to have_selector('a', text: 'New Post')
      end
    end

  end


  describe "New post",  :type => :feature do
    subject(:user){ users[0]}
    before { login user; posts_page.new_button.click }

    scenario "Load page with form" do
      expect(page).to have_content 'New Post'
      expect(page).to have_selector('form', id: "new_post")
    end
    scenario "WYSIWYG in markdown" do
      # posts_page.fill_text_md('# My title of post by capybara test')
      # posts_page.button_preview_side.click
      # html = posts_page.preview_side.text
      # expect(html).to equal("<h1>My title of post by capybara test</h1>")
    end
    scenario "Create" do
      posts_page.fill_form(title: 'My title of post by capybara test')
      click_button("Create Post")

      expect(page).to have_selector('a', id: 'original-link')
      expect(page).to have_selector('a', id: 'blog-link')
    end
  end

end
