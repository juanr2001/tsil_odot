module AuthenticationHelpers

    module Controller

        def sign_in(user)
            #To make sure an User object is return
            allow(controller).to receive_message_chain( :current_user ).and_return(user)
             # allow(controller).to receive( :user_id ).and_return(user.id)
             # allow(controller).to receive_message_chain(:user_id).and_return(user.id)
        end

    end

    module Feature

        def sign_in( user, options = {} )
            visit "/login"
            fill_in "Email", with: user.email
            fill_in "Password", with: options[ :password ]
            click_button "Sign In"
        end

    end

end