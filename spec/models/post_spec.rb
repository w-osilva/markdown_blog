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

  describe "#assossiations" do
    it { should belong_to(:user) }
  end

  describe ".attributes" do
    subject(:post) { posts[0] }
    it {expect(post.attributes).to include("id", "user_id", "title", "text_md", "text_md", "text_html", "status", "created_at", "updated_at", "file", "slug")}

    context "required" do
      subject(:invalid_attributes) { FactoryGirl.attributes_for(:post, title: nil, text_md: nil, user: nil) }
      let (:build_post) { FactoryGirl.build(:post, invalid_attributes) }

      it ".title" do
        expect(build_post.save).to be false
      end
      it ".text_md" do
        expect(build_post.save).to be false
      end
      it ".user" do
        expect(build_post.save).to be false
      end
    end
  end

  describe "#default_scope" do
    specify "posts should be in descending order by created_at attribute" do
      posts = Post.all
      posts.each_with_index do |post, key|
        next_post = posts[key + 1]
        expect(post.created_at).to be > next_post.created_at if next_post.present?
      end
    end
  end

  describe "#before_create" do
    context ".set_default_attributes" do
      subject(:post) { FactoryGirl.build(:post) }
      specify do
        expect(post).to receive(:set_default_attributes).once
        post.save
      end
    end
  end

end
