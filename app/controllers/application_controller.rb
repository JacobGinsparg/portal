class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  
  # Uncomment this line once main page is decided. Then add "|| self.controller_name == 'main_page_controller'" to the end of the 'return if' statement in :admin_user
  # before_action :admin_user, except: ['destroy']
  
  def admin_user
    return if self.controller_name == 'sessions' || self.controller_name == 'omniauth_callbacks'
    unless current_user && current_user.admin
      flash[:alert] = "You cannot access this page."
      redirect_to '/'
    end
  end
end
