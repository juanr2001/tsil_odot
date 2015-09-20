class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success

  private
  def logged_in?
    current_user
  end
  helper_method( :logged_in? )

  #methods I can call later in any controller in the my app
  #this make my todo_list_controller fail because now it requires a user.
  def current_user
    #conditional assignment
    @current_user ||= User.find( session[ :user_id ] ) if session[ :user_id ]
  end
  helper_method( :current_user )

  def require_user
    if current_user
        true
    else
        redirect_to new_user_session_path, notice: "You must me logged in"
    end
  end
end
