require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user) { FactoryGirl.create(:user, {email: 'admin@example.com', password: 'mysecretpassword', nickname: 'admin', first_name: 'admin', last_name: 'blog'}) }

  describe "#assossiations" do
    it { should have_many(:posts) }
  end

  describe ".attributes" do
    it { expect(user.attributes).to include("id", "email", "nickname", "first_name", "last_name", "first_name", "photo",
                                            "created_at", "updated_at",
                                            "current_sign_in_at", "current_sign_in_ip", "encrypted_password",
                                            "last_sign_in_at", "last_sign_in_ip" ,"remember_created_at",
                                            "reset_password_sent_at", "reset_password_token", "sign_in_count"
    )}

    context "required" do
      subject(:invalid_attributes) { FactoryGirl.attributes_for(:user, first_name: nil, nickname: nil) }
      let (:build_user) { FactoryGirl.build(:user, invalid_attributes) }

      it ".nickname" do
        expect(build_user.save).to be false
      end
      it ".first_name" do
        expect(build_user.save).to be false
      end
    end
  end

  describe ".to_s" do
    it { expect(user.to_s).to eq "#{user.first_name} #{user.last_name}"}
  end

end
