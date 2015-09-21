require 'rails_helper'
#Now I have to specify what I am testing with RSpec...
RSpec.feature "Todo List", :type => :feature do

    describe "Creating todo lists" do
        #User Object
        let( :user ) { create(:user) }

        def create_todo_list( options = { } )
            options[:title] ||= "My todo list"

            visit "/todo_lists"
            #This is how I can output the html to makesure what is the output, for debuggin
            # puts page.body
            click_link "New Todo list"
            expect(page).to have_content("New Todo List")

            fill_in "Title", with: options[:title]
            click_button "Create Todo list"
        end

        before do
            #Used same password created in factories.rb
            sign_in( user, password: "blagsa" )
        end

        it "redirects to the todo list index page on success" do
            create_todo_list()
            expect(page).to have_content("My todo list")
        end

        it "display an error when the todo list has no title" do
           expect(TodoList.count).to eq(0)
           create_todo_list title: ""

            expect(page).to have_content("error")
            expect(TodoList.count).to eq(0)

            visit "/todo_lists"
            expect(page).to_not have_content("This is what I'm doing today")
        end

        it "display an error when the todo list has a title less than 3 character" do
            expect(TodoList.count).to eq(0)
            create_todo_list title: "Hi"

            expect(page).to have_content("error")
            expect(TodoList.count).to eq(0)

            visit "/todo_lists"
            expect(page).to_not have_content("This is what I'm doing today")
        end
    end
end