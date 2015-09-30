module Api
    class ApiController < ApplicationController

        protect_from_forgery
        skip_before_filter :verify_authenticity_token

        #For API Rails suggestion.
        protect_from_forgery with: :null_session

        before_action :authenticate

=begin
    terminal command
        --basic \
        -u juan:1234 \
        http://localhost:3000/api/todo_lists.json
        HTTP Basic: Access denied.
=end

#basic authentication
        # def authenticate
        #     authenticate_or_request_with_http_basic do | user, password |
        #         user == "juan" && password == "juan"
        #     end
        # end

=begin
    terminal command using email
        --basic \
        -u juanordaz@google.com:123456 \
        http://localhost:3000/api/todo_lists.json
=end


        # Eventhough I already have a current user method defined in the application controller,
        # My API controller inherits from it. Therefore this current user method is goin to overwrite that method for the API controller and its subclasses

        def current_user
            @current_user
        end

        def authenticate
            authenticate_or_request_with_http_basic do | email, password |
                Rails.logger.info "API Authentication:#{email} #{password}"
                user = User.find_by(email: email)
                if user && user.authenticate(password)
                    @current_user = user
                    Rails.logger.info "Logging in #{user.inspect}"
                    true
                else
                    Rails.logger.warn "No valid credentials."
                    false
                end
            end
        end

    end
end