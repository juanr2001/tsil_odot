class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :error

  #Rescue from not finding a Active Record User Object
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  #if I have an invalid signature. If I user edit the cookie it raises Message Verifier
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_error


  private

  def go_back_link_to(path)
    @go_back_link_to ||= path
    @go_back_link_to
  end

  def render_404
    respond_to do | format |
      format.html do
        render file: 'public/404.html', status: :not_found, layout: false
      end
      format.json do
        render status: 404, json: {
          message: "Not found."
        }
      end
    end
  end

  def render_error
        render file: 'public/500.html', status: :internal_server_error, layout: false
  end

  def logged_in?
    current_user
  end
  helper_method( :logged_in? )

  #methods I can call later in any controller in the my app
  #this make my todo_list_controller fail because now it requires a user.
  def current_user
    #conditional assignment
      if session[ :user_id ]
        @current_user ||= User.find( session[ :user_id ] )
      elsif cookies.permanent.signed[ :remember_me_token ]
        verification = Rails.application.message_verifier( :remember_me ).verify( cookies.permanent.signed[ :remember_me_token ] )
        if verification
          Rails.logger.info "Logging in by cookie."
          @current_user ||= User.find( verification )
        end
      end
  end
  helper_method :current_user

  def require_user
    if current_user
        true
    else
        redirect_to new_user_session_path, notice: "You must me logged in"
    end
  end
end
