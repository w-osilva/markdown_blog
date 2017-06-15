require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protect_from_forgery with: :exception
  before_action :authenticate_user!, unless: -> { controller_name == 'posts' }
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:danger] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(root_path)
  end

  def not_found
    flash[:danger] = "Resource Not Found"
    redirect_to root_path
  end

end
