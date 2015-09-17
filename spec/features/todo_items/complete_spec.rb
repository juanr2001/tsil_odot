require 'rails_helper'

RSpec.feature "Todo List", :type => :feature do

    describe "Editing todo items" do
        let!(:todo_list) {TodoList.create(title: "Homework", description: "Math test") }
        #I'm passing the object above to the bottom,since they have relationship
        let!(:todo_item) { todo_list.todo_items.create(content: "Study") }


        it "is successful when marking a single item complete" do
            #going to make sure the item is empty
            expect(todo_item.completed_at).to be_nil
            visit_todo_list(todo_list)

            #make sure the item is now not empty
            within dom_id_for(todo_item) do
                click_link "Mark Complete"
            end

            todo_item.reload
            #not it sould not be empty
            expect(todo_item.completed_at).to_not be_nil
        end
    end
end