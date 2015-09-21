require 'rails_helper'

RSpec.feature "Todo List", :type => :feature do

    describe "Editing todo items" do

        let( :user ) { todo_list.user }
        let!( :todo_list ) { create( :todo_list ) }
        let!( :todo_item ) { todo_list.todo_items.create( content: "Study" ) }
        before { sign_in user, password: "blagsa" }

        #This fails bc I created associations
        # let!(:todo_list) {TodoList.create(title: "Homework", description: "Math test") }
        # #I'm passing the object above to the bottom,since they have relationship
        # let!(:todo_item) { todo_list.todo_items.create(content: "Study") }


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

        #share piece of behavior and orginaze them different inside of my test files.
        context "with completed items" do
            let!( :completed_todo_item ) { todo_list.todo_items.create( content: "English Quiz", completed_at: 5.minutes.ago ) }

            it "show an option to mark incomplete" do
                visit_todo_list( todo_list )
                within dom_id_for( completed_todo_item ) do
                    expect(page).to have_content("Mark Incomplete")
                end
            end

            it "does not give the option to mark complete" do
                visit_todo_list( todo_list )
                within dom_id_for( completed_todo_item ) do
                    expect( page ).to_not have_content( "Mark Complete" )
                end
            end


        end
    end
end