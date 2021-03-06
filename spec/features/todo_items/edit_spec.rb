require 'rails_helper'

RSpec.feature "Todo List", :type => :feature do

    describe "Editing todo items" do

        let( :user ) { todo_list.user }
        let!( :todo_list ) { create( :todo_list ) }
        let!(:todo_item) { todo_list.todo_items.create( content: "Study" ) }
        before { sign_in user, password: "blagsa" }

        #Changed this code because I now have associations
        # let!(:todo_list) {TodoList.create(title: "Homework", description: "Math test") }
        # #I'm passing the object above to the bottom,since they have relationship
        # let!(:todo_item) { todo_list.todo_items.create(content: "Study") }


        it "is successful with valid content" do
            visit_todo_list(todo_list)
            within("#todo_item_#{todo_item.id}") do
                click_link todo_item.content
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
                click_link todo_item.content
            end
            fill_in "Content", with: ""
            click_button "Save"
            expect(page).to_not have_content("Saved todo list item.")
            expect(page).to have_content(/can't be blank/i)
            todo_item.reload
            #I have to make sure the content still "Study"
            expect(todo_item.content).to eq("Study")
        end

        it "is unsuccessful with not enough content" do
            visit_todo_list(todo_list)
            within("#todo_item_#{todo_item.id}") do
                click_link todo_item.content
            end
            fill_in "Content", with: "h"
            click_button "Save"
            expect(page).to_not have_content("Saved todo list item.")
            expect(page).to have_content(/is too short/i)
            todo_item.reload
            #I have to make sure the content still "Study"
            expect(todo_item.content).to eq("Study")
        end

    end
end