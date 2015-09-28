require 'rails_helper'
#Now I have to specify what I am testing with RSpec...
RSpec.feature "User", :type => :feature do

    describe "Signing up" do
        it "allows a user to sign up for the site and creates the object in the database" do
            expect( User.count ).to eq(0)

            visit "/"
            expect(page).to have_content("Sign Up")
            click_link "Sign Up"

            fill_in "First Name", with: "First Name"
            fill_in "Last Name", with: "Last Name"
            fill_in "Email", with: "email@example.com"
            fill_in "Password", with: "password"
            fill_in "Password (again)", with: "password"
            click_button "Sign Up"

            expect(User.count).to eq(1)
        end

        it "displays a tutorial when user signs up" do
            visit "/"
            expect(page).to have_content("Sign Up")
            click_link "Sign Up"

            fill_in "First Name", with: "First Name"
            fill_in "Last Name", with: "Last Name"
            fill_in "Email", with: "email@example.com"
            fill_in "Password", with: "password"
            fill_in "Password (again)", with: "password"
            click_button "Sign Up"

            expect(page).to have_content( "ODOT Tutorial" )
            click_on "ODOT Tutorial"
            expect( page.all( "li.todo-item").size ).to eq( 7 )
        end
    end
end
