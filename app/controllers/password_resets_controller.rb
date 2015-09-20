class PasswordResetsController < ApplicationController

    def new
    end
    def create
        #this code is to just make my test to pass for now
        user = User.find_by(email: params[ :email ] )
        user.generate_password_reset_token!
        Notifier.password_reset(user).deliver_now
        redirect_to login_path
    end

end
