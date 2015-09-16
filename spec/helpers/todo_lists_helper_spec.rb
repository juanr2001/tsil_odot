require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TodoListsHelper. For example:
#
# describe TodoListsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TodoListsHelper, type: :helper do
  describe "#todo_list_title" do
    it "returns the default title" do
      expect(helper.todo_list_title).to eql("My title")
    end
  end
end