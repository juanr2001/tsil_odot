require 'rails_helper'
#Now I have to specify what I am testing with RSpec...
RSpec.feature "Todo List", :type => :feature do

    describe "Editing todo lists" do
        #User object
        # let( :user ) { create( :todo_list ) }
        let( :user ) { todo_list.user }


        let! ( :todo_list ) { create( :todo_list ) }
        #another way I can do this is calling the User object on top
        # let! ( :todo_list ) { create( :todo_list, user: user  ) }

        def update_todo_list( options = { } )
            options[ :title ] ||= "My todo list"

            todo_list = options[ :todo_list ]

            visit "/todo_lists"
            #Here I tell Capybara to select an object with an id.
            within "#todo_list_#{todo_list.id}" do
                click_link "Edit"
            end

            fill_in "Title", with: options[:title]
            click_button "Update Todo list"
        end

        #sign_in user here
        before do
            #Used same password created in factories.rb
            #I sign in a todo_list user, instead of the User object on top
            sign_in( todo_list.user, password: "blagsa" )
        end

        it "updates a todo list successfully with correct information" do

            update_todo_list todo_list: todo_list,
                                        title: "New title"

            #So This code is what fetch the lates update from the database.
            todo_list.reload

            expect(page).to have_content("Todo list was successfully updated")
            #When I run the test it fail until it hits this line, because it didn't take the new value in the database
            #to get the test to pass I need to write 'todo_list.reload' make the test fetch the updated value from the database.
            expect(todo_list.title).to eq("New title")
        end

        it "displays an error with no title" do
            update_todo_list todo_list: todo_list, title: ""

            title = todo_list.title
            todo_list.reload
            expect(todo_list.title).to eq(title)

            expect(page).to have_content("error")
        end

        it "displays an error with too short attr_reader :name title" do
            update_todo_list todo_list: todo_list, title: "Hi"
            expect(page).to have_content("error")
        end
    end
end