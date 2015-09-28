require 'rails_helper'
#Now I have to specify what I am testing with RSpec...
RSpec.feature "User", :type => :feature do

    describe "Logging in" do
        it "logs the user in and goes to the todo lists" do
            User.create( first_name: "Juan", last_name: "Ordaz", email: "juanordaz@gmail.com", password: "password", password_confirmation: "password" )

            visit "/"
            click_link "Sign in"
            fill_in "Email Address", with: "juanordaz@gmail.com"
            fill_in "Password", with: "password"
            click_button "Sign In"
            expect(page).to have_content( "Todo Lists" )
            expect(page).to have_content( "Thanks for logging in!" )
        end

        it "displays the email address in the event of the failed login" do
            visit new_user_session_path
            fill_in "Email Address", with: "juanordaz@gmail.com"
            fill_in "Password", with: "incorrect"
            click_button "Sign In"

            expect( page ).to have_content( "Please check your email and password" )
            expect( page ).to have_field( "Email Address", with: "juanordaz@gmail.com" )
        end
    end

end