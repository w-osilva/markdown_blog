require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:invalid_attributes) { {titulo: ''} }
  let(:valid_attributes) { FactoryGirl.attributes_for(:post) }

  let!(:new_post){ FactoryGirl.create(:post) }

  describe "GET #index" do
    it "Expected all posts as @posts" do
      get :index, params: {}, session: valid_session
      expect(assigns(:posts)).to eq([new_post])
    end
  end

   describe "GET #show" do
    it "Expected can be listed a specific post" do
      get :show, params: {id: new_post.id}, session: valid_session
      expect(assigns(:post)).to eq(new_post)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "Create a new Post" do
        expect {
          post :create, params: {post: valid_attributes}, session: valid_session
        }.to change(Post, :count).by(1)
      end

      it "Expected can be create one @post" do
        post :create, params: {post: valid_attributes}, session: valid_session
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end
    end

    context "with invalid params" do
      it "Expected one attempt of create one post don't be save" do
        post :create, params: {post: invalid_attributes}, session: valid_session
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "Render template 'new' again" do
        post :create, params: {post: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid parameters" do
      it "request to update post" do
        put :update, params: {id: new_post.to_param, post: valid_attributes}, session: valid_session
        new_post.reload
      end

      it "Expected the requested post as @post" do
        put :update, params: {id: new_post.to_param, post: valid_attributes}, session: valid_session
        expect(assigns(:post)).to eq(new_post)
      end

      it "redirect to posts" do
        put :update, params: {id: new_post.to_param, post: valid_attributes}, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end

    context "with valid parameters" do
      it "Expected to be the @post was rendered" do
        put :update, params: {id: new_post.id, post: valid_attributes}, session: valid_session
        expect(assigns(:post)).to eq(new_post)
      end

      it "Render the template 'edit' again" do
        put :update, params: {id: new_post.id, post: invalid_attributes}, session: valid_session
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE #destroy" do
    it "Expected to be excluded a selected post" do
      expect {
        delete :destroy, params: {id: new_post.id}, session: valid_session
      }.to change(Post, :count).by(0)
    end

    it "Expected to be redirected to list of posts" do
      delete :destroy, params: {id: new_post.id}, session: valid_session
      expect(response).to redirect_to(root_path)
    end
  end

end
