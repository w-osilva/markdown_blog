require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "Listing posts" do
      get posts_path
      expect(response).to have_http_status(200)
    end
  end
end
