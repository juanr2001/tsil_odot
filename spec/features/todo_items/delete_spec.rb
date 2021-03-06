require 'rails_helper'

RSpec.feature "Todo Item", :type => :feature do

    describe "Deleting todo items" do

        let( :user ) { todo_list.user }
        let!( :todo_list ) { create( :todo_list ) }
        let!(:todo_item) { todo_list.todo_items.create( content: "Study") }
        before { sign_in user, password: "blagsa" }

        #change this code bc I have associations with the user
        # let!(:todo_list) {TodoList.create(title: "Homework", description: "Math test") }
        # #I'm passing the object above to the bottom,since they have relationship
        # let!(:todo_item) { todo_list.todo_items.create(content: "Study") }


        it "is successful" do
            visit_todo_list(todo_list)
            click_on todo_item.content
            # within "#todo_item_#{todo_item.id}" do
            #     click_link "Delete"
            click_link "Delete"
            # end
            expect(page).to have_content("Todo list item was deleted.")
            expect(TodoItem.count).to eq(0)
        end
    end
end