require 'rails_helper'
#Now I have to specify what I am testing with RSpec...
RSpec.feature "Todo List", :type => :feature do

    describe "Listing todo lists" do
        it "requires login" do
            visit "/todo_lists"
            expect( page ).to have_content( "You must me logged in" )
        end

    end
end
