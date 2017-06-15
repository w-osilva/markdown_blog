module ControllerSpecHelpers

  def valid_session
    user = FactoryGirl.create(:user)
    sign_in user, scope: :user
  end

end