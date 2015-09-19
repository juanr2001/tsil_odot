require 'rails_helper'

RSpec.feature "Todo List", :type => :feature do

    describe "Viewing todo items" do
        let( :user ) { create( :user ) }
        before { sign_in user, password: "blagsa" }
        let!(:todo_list) {TodoList.create(title: "Homework", description: "Math test coming up") }

        it "displays the title of the title of the todo list" do
            visit_todo_list(todo_list)
            within("div.content h1") do
                expect(page).to have_content(todo_list.title)
            end
        end


        it "displays no items when a todo list is empty" do
            visit_todo_list(todo_list)
            #capybara, (.all) selects a css selector
            expect(page.all("table.todo_items tbody tr").size).to eq(0)
        # expect(page).to have_content("TodoItems#index")
        end


        it "displays item content when a todo list has items" do
            #created item before visiting the todo_list
            todo_list.todo_items.create(content: "Milk")
            todo_list.todo_items.create(content: "Eggs")

            #then I visit the todo list page
            visit_todo_list(todo_list)

            #expect to see the items created
            expect(page.all("table.todo_items tbody tr").size).to eq(2)

            #this is how I should see it.
            within "table.todo_items" do
                expect(page).to have_content("Eggs")
                expect(page).to have_content("Milk")
            end
        end

    end
end