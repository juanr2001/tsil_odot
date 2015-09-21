require 'rails_helper'
#Now I have to specify what I am testing with RSpec...
RSpec.feature "Todo List", :type => :feature do

    describe "Deleting todo lists" do
        #User Object

        let( :user ) { todo_list.user }


        let! ( :todo_list ) { create( :todo_list ) }

#sign_in
        before do
            #Used same password created in factories.rb
            sign_in( user, password: "blagsa" )
        end

        it "is successful when clicking the destroy link" do
            pending "Deleting todo lists"
            visit "/todo_lists"

            within "#todo_list_#{todo_list.id}" do
                click_link "Destroy"
            end

            expect(page).to_not have_content(todo_list.title)
            expect(TodoList.count).to eq(0)
        end
    end
end