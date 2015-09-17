require 'rails_helper'

RSpec.describe TodoItem, type: :model do
    describe TodoItem do
        it { should belong_to(:todo_list) }

        #To is going to look for the completed? method
        #context or describe is almost the same.
        describe "#completed?" do
            let( :todo_item ) { TodoItem.create( content: "Hello" ) }

            it "is false when completed_at is blank" do
                todo_item.completed_at = nil
                expect( todo_item.completed?).to be_falsy
            end

            it "returns true when completed_at is not empty" do
                todo_item.completed_at = Time.now
                expect(todo_item.completed?).to be_truthy
            end
        end
    end
end
