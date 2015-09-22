require 'rails_helper'
#Now I have to specify what I am testing with RSpec...
RSpec.feature "User", :type => :feature do
    describe "Forgotten password" do
        let!( :user ) { create(:user ) }

        it "sends a user an email" do
            visit login_path
            click_link "Forgot Password"
            fill_in "Email", with: user.email
            expect {
                click_button "Reset Password"
            }.to change{ ActionMailer::Base.deliveries.size }.by( 1 )
        end

        it "resets a password when following the email link" do
            visit login_path
            click_link "Forgot Password"
            fill_in "Email", with: user.email
            click_button "Reset Password"
            open_email( user.email )
            current_email.click_link 'http://'
            expect( page ).to have_content( "Change Your Password" )

            fill_in "Password", with: "new_password"
            fill_in "Password (again)", with: "new_password"
            click_button "Change Password"
            expect( page ).to have_content( "Password updated" )
            expect( page.current_path ).to eq( todo_lists_path )

            click_link "Sign Out"
            expect( page ).to have_content( "You must me logged in" )
            visit login_path
            fill_in "Email", with: user.email
            fill_in "Password", with: "new_password"
            click_button "Sign In"
            expect( page ).to have_content( "Thanks for logging in" )
        end
    end

end