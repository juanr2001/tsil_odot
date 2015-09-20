require "spec_helper"
RSpec.feature "User", :type => :feature do
    describe "Logging Out" do
      it "allows a signed in user to sign out" do
        user = create(:user)
        visit "/todo_lists"
        expect(page).to have_content("Log In")
        fill_in "Email", with: user.email
        fill_in "Password", with: "blagsa"
        click_button "Log In"

        expect(page).to have_content("Log Out")
        click_link "Log Out"
        expect(page).to_not have_content("Log Out")
        expect(page).to have_content("Log In")
     end
    end
end