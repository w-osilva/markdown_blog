require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "Validanting method to_s" do
    it "Expected to be concated the string of first_name with last_name" do
      new_post = FactoryGirl.create(:post_not_published)
      expect {
        delete :destroy, params: {id: new_post.id}, session: valid_session
      }.to change(Post, :count).by(0)
    end
  end

end
