require 'rails_helper'

RSpec.describe "todo_lists/index", type: :view do
  before(:each) do
    assign(:todo_lists, [
      TodoList.create!(
        :title => "Title",
      ),
      TodoList.create!(
        :title => "Title",
      )
    ])
  end

  it "renders a list of todo_lists" do
    render
    assert_select "div.todo_list h2", :text => "Title".to_s, :count => 2
  end
end