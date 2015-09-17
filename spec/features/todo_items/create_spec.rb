require 'rails_helper'

RSpec.feature "Todo List", :type => :feature do

    describe "Adding todo items" do
        let!(:todo_list) {TodoList.create(title: "Homework", description: "Math test coming up") }


        it "is successful with valid content" do
            visit_todo_list(todo_list)
            click_link "New Todo Item"
            fill_in "Content", with: "Milk"
            click_button "Save"
            expect(page).to have_content("Added todo list item.")
            within("ul.todo_items") do
                expect(page).to have_content("Milk")
            end
        end

        it "displays an error with no content" do
            visit_todo_list(todo_list)
            click_link "New Todo Item"
            fill_in "Content", with: ""
            click_button "Save"
            #checking the flash message from the controller.
            within("div.flash") do
                expect(page).to have_content("There was a problem adding that todo item")
            end
            expect(page).to have_content("Content can't be blank")
        end

        it "displays an error with content less than 2 characters long" do
            visit_todo_list(todo_list)
            click_link "New Todo Item"
            fill_in "Content", with: "H"
            click_button "Save"
            #checking the flash message from the controller.
            within("div.flash") do
                expect(page).to have_content("There was a problem adding that todo item")
            end
            expect(page).to have_content("Content is too short")
        end
    end
end