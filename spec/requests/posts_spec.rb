require 'rails_helper'

RSpec.describe "Posts", type: :request do

  let(:valid_attributes) { FactoryGirl.attributes_for(:post) }
  let!(:user){ FactoryGirl.create(:user) }
  let!(:new_post){ FactoryGirl.create(:post, user: user) }

  describe "As a guest user" do
    describe "GET /posts" do
      it "Listing posts" do
        get posts_path
        expect(response).to have_http_status(:ok)
      end
    end

    describe "GET /posts/:id" do
      it "Show a post" do
        get post_path(new_post)
        expect(response).to have_http_status(:ok)
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

  describe "As a registered user" do

    before{ sign_in user }

    describe "GET /posts/new" do
      it "Form new post" do
        get new_post_path
        expect(response).to have_http_status(:ok)
      end
    end

    describe "POST /posts/create" do
      it "Create post" do
        post posts_path, params: {post: valid_attributes}
        expect(response).to redirect_to(assigns(:post))
      end
    end

    describe "GET /posts/:id/edit" do
      it "Form edit post" do
        get edit_post_path(new_post)
        expect(response).to have_http_status(:ok)
      end
    end

    describe "PUT /posts/:id/update" do
      it "Update post" do
        put post_path(new_post),params: { post: new_post.attributes }
        expect(response).to redirect_to(assigns(:post))
      end
    end

    describe "DELETE /posts/:id" do
      it "Destroy post" do
        delete post_path(new_post)
        expect(response).to redirect_to(posts_path)
      end
    end

    subject(:post_from_another){ FactoryGirl.create(:post) }
    specify "The registered user can only manage their own posts" do
      # Form edit
      get edit_post_path(post_from_another)
      expect(response).not_to have_http_status(:ok)
      expect(flash[:danger]).to match(/Unauthorized access/)

      # Update
      put post_path(post_from_another),params: { post: post_from_another.attributes }
      expect(response).not_to redirect_to(posts_path)
      expect(flash[:danger]).to match(/You cannot edit this resource/)

      # Destroy
      delete post_path(post_from_another)
      expect(response).not_to redirect_to(posts_path)
      expect(flash[:danger]).to be_present
    end

  end


end
