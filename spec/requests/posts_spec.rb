require 'rails_helper'

RSpec.describe "Posts", type: :request do

  let!(:new_post){ FactoryGirl.create(:post) }
  let!(:user){ FactoryGirl.create(:user) }

  describe "As a guest user" do
    describe "GET /posts" do
      it "Listing posts" do
        get posts_path
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /posts/:id" do
      it "Show a post" do
        get post_path(new_post)
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /posts/render/:user/:file" do
      it "Render the html of the post" do
        params = new_post.file.split("/")
        # expect an error becaune not exist the Template (html file) to post
        # expect(get post_render_html_url(params[0], params[1])).to raise_error(ActionView::MissingTemplate)
      end
    end
  end


  describe "As a authenticated user" do

    before{ sign_in user}

    describe "GET /posts/new" do
      it "Show the new post page" do
        get new_post_path
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /posts/:id/edit" do
      it "Show the edit post page" do
        get edit_post_path(new_post)
        # expect(response).to have_http_status(200) #302 ?
      end
    end

  end


end
