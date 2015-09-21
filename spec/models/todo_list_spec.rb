require 'rails_helper'

RSpec.describe TodoList, type: :model do
    context "relationships" do
        it { should have_many( :todo_items ) }
        it { should belong_to( :user ) }
    end

    describe "#has_completed_items?" do
        let( :todo_list ) { TodoList.create( title: "Study" ) }

        it "returns true with completed todo list item" do
            todo_list.todo_items.create( content: "Study a lot", completed_at: 1.minute.ago )
            expect( todo_list.has_completed_items? ).to be_truthy
        end

        it "returns false with no completed todo list items" do
            todo_list.todo_items.create( content: "Study a lot" )
            expect( todo_list.has_completed_items? ).to be_falsy
        end
    end

    describe "#has_incomplete_items?" do
        let( :todo_list ) { TodoList.create( title: "Study" ) }

        it "returns true with incompleted todo list items" do
            todo_list.todo_items.create( content: "Study a lot" )
            expect( todo_list.has_incomplete_items? ).to be_truthy
        end

        it "returns false with no incompleted todo list items" do
            todo_list.todo_items.create( content: "Study a lot", completed_at: 1.minute.ago )
            expect( todo_list.has_incomplete_items? ).to be_falsy
        end


    end
end