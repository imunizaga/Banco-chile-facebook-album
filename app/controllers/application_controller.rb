class ApplicationController < ActionController::Base
  rescue_from Koala::Facebook::APIError, :with => :auth_redirect

  def auth_redirect
    redirect_to '/auth/facebook'
  end

end
