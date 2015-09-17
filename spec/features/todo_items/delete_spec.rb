require 'rails_helper'

RSpec.feature "Todo List", :type => :feature do

    describe "Deleting todo items" do
        let!(:todo_list) {TodoList.create(title: "Homework", description: "Math test") }
        #I'm passing the object above to the bottom,since they have relationship
        let!(:todo_item) { todo_list.todo_items.create(content: "Study") }


        it "is successful" do
            visit_todo_list(todo_list)
            within "#todo_item_#{todo_item.id}" do
                click_link "Delete"
            end
            expect(page).to have_content("Todo list item was deleted.")
            expect(TodoItem.count).to eq(0)
        end


    end
end