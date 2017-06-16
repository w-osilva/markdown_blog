require 'rails_helper'

RSpec.describe Post, type: :model do

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

  describe "validate assossiations" do
    it { should belong_to(:user) }
  end

  describe "attributes" do
    subject(:post) { posts[0] }
    it {expect(post.attributes).to include("id", "user_id", "title", "text_md", "text_md", "text_html", "status", "created_at", "updated_at", "file", "slug")}
  end

  describe "default_scope" do
    it "posts should be in descending order by created_at attribute" do
      posts = Post.all
      posts.each_with_index do |post, key|
        next_post = posts[key + 1]
        expect(post.created_at).to be > next_post.created_at if next_post.present?
      end
    end
  end

end
