require 'rails_helper'

RSpec.feature "Todo List", :type => :feature do

    describe "Editing todo items" do
        let!(:todo_list) {TodoList.create(title: "Homework", description: "Math test") }
        #I'm passing the object above to the bottom,since they have relationship
        let!(:todo_item) { todo_list.todo_items.create(content: "Study") }


        it "is successful with valid content" do
            visit_todo_list(todo_list)
            within("#todo_item_#{todo_item.id}") do
                click_link "Edit"
            end
            fill_in "Content", with: "Study Multiplications"
            click_button "Save"
            expect(page).to have_content("Saved todo list item.")
            todo_item.reload
            expect(todo_item.content).to eq("Study Multiplications")
        end

        it "is unsuccessful with no valid content" do
            visit_todo_list(todo_list)
            within("#todo_item_#{todo_item.id}") do
                click_link "Edit"
            end
            fill_in "Content", with: ""
            click_button "Save"
            expect(page).to_not have_content("Saved todo list item.")
            expect(page).to have_content("Content can't be blank")
            todo_item.reload
            #I have to make sure the content still "Study"
            expect(todo_item.content).to eq("Study")
        end

        it "is unsuccessful with not enough content" do
            visit_todo_list(todo_list)
            within("#todo_item_#{todo_item.id}") do
                click_link "Edit"
            end
            fill_in "Content", with: "h"
            click_button "Save"
            expect(page).to_not have_content("Saved todo list item.")
            expect(page).to have_content("Content is too short (minimum is 2 characters)")
            todo_item.reload
            #I have to make sure the content still "Study"
            expect(todo_item.content).to eq("Study")
        end

    end
end