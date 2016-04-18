class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # make this methods available to all the views
  helper_method :current_user, :logged_in?

  def current_user
    # memoization, instance variable, so we dont hit the database per view
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end

  # !!turns it into true or false, does it exist or not?
  def logged_in?
    !!current_user
  end

end
