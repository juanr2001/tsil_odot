class Notifier < ApplicationMailer

    #this is needed, bc an email does not what host is from.
    default_url_options[ :host ] = "localhost:3000"
    default from: "no-reply@example.com"

    def password_reset(user)
        @user = user
        mail( to: "#{user.first_name} #{user.last_name} <#{user.email}>",
                subject: "Reset Your Password" )
    end
end
