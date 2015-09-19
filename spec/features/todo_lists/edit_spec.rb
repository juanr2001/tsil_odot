require 'rails_helper'
#Now I have to specify what I am testing with RSpec...
RSpec.feature "Todo List", :type => :feature do

    describe "Editing todo lists" do
        #User object
        let( :user ) { create( :user ) }

        let! ( :todo_list ) { TodoList.create( title: "Homework", description: "Math Project" ) }


        def update_todo_list( options = { } )
            options[ :title ] ||= "My todo list"
            options[ :description ] ||= "This is my todo list"

            todo_list = options[ :todo_list ]

            visit "/todo_lists"
            #Here I tell Capybara to select an object with an id.
            within "#todo_list_#{todo_list.id}" do
                click_link "Edit"
            end

            fill_in "Title", with: options[:title]
            fill_in "Description", with: options[:description]
            click_button "Update Todo list"
        end

        #sign_in user here
        before do
            #Used same password created in factories.rb
            sign_in( user, password: "blagsa" )
        end

        it "updates a todo list successfully with correct information" do

            update_todo_list todo_list: todo_list,
                                        title: "New title",
                                        description: "New Description"

            #So This code is what fetch the lates update from the database.
            todo_list.reload

            expect(page).to have_content("Todo list was successfully updated")
            #When I run the test it fail until it hits this line, because it didn't take the new value in the database
            #to get the test to pass I need to write 'todo_list.reload' make the test fetch the updated value from the database.
            expect(todo_list.title).to eq("New title")
            expect(todo_list.description).to eq("New Description")
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

        it "displays an error with no description" do
            update_todo_list todo_list: todo_list, description: ""
            expect(page).to have_content("error")
        end

        it "displays an error with too short a description" do
            update_todo_list todo_list: todo_list, description: "hi"
            expect(page).to have_content("error")
        end

    end
end