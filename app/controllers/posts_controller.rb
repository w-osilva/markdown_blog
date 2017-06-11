class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :load_user

  def index
    @posts = Post.page(params[:page])
    respond_with @posts
  end

  def show
    respond_with @post
  end

  def new
    build_post
  end

  def edit
  end

  def create
    build_post
    save_post or render :new
  end

  def update
    build_post
    save_post or render :update
  end

  def destroy
    destroy_post or render :index
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    post_params = params[:post]
    post_params ? post_params.permit(:title, :slug, :url, :text_md, :text_html, :user_id) : {}
  end

  def build_post
    @post ||= Post.new
    @post.user = @user
    @post.attributes = post_params
  end

  def load_user
    @user = current_user
  end

  def save_post
    respond_with(@post, :location => post_path(@post)) if @post.save
  end

  def destroy_post
    @post.destroy
    flash[:danger] = @post.errors.full_messages.to_sentence if @post.errors.any?
    respond_with @post, location: posts_path
  end

end
