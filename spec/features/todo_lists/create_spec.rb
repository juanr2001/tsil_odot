require 'rails_helper'
#Now I have to specify what I am testing with RSpec...
RSpec.feature "Todo List", :type => :feature do

    describe "Creating todo lists" do
        def create_todo_list( options = { } )
            options[:title] ||= "My todo list"
            options[:description] ||= "The is my todo list"

            visit "/todo_lists"
            click_link "New Todo list"
            expect(page).to have_content("New Todo List")

            fill_in "Title", with: options[:title]
            fill_in "Description", with: options[:description]
            click_button "Create Todo list"
        end

        it "redirects to the todo list index page on success" do
            create_todo_list()
            expect(page).to have_content("My todo list")
        end

        it "display an error when the todo list has no title" do

           create_todo_list title: ""

            expect(page).to have_content("error")
            expect(TodoList.count).to eq(0)

            visit "/todo_lists"
            expect(page).to_not have_content("This is what I'm doing today")
        end

        it "display an error when the todo list has a title less than 3 character" do

            create_todo_list title: "Hi"

            expect(page).to have_content("error")
            expect(TodoList.count).to eq(0)

            visit "/todo_lists"
            expect(page).to_not have_content("This is what I'm doing today")
        end

        it "display an error when the todo list has no description" do

            create_todo_list title: "Homework", description: ""

            expect(page).to have_content("error")
            expect(TodoList.count).to eq(0)

            visit "/todo_lists"
            expect(page).to_not have_content("Homework")
        end

        it "display an error when the todo list has no description" do

            create_todo_list title: "Homework", description: "Math"

            expect(page).to have_content("error")
            expect(TodoList.count).to eq(0)

            visit "/todo_lists"
            expect(page).to_not have_content("Homework")
        end
    end
end