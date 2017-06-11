require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

end
