require 'rails_helper'

RSpec.feature "Todo List", :type => :feature do

    let!(:todo_list) {TodoList.create(title: "Homework", description: "Math test coming up") }
    describe "Viewing todo items" do
        it "displays no items when a todo list is empty" do
            visit "/todo_lists"
            within "#todo_list_#{todo_list.id}" do
                click_link "List Items"
        end
        expect(page).to have_content("TodoItem#index")
    end
end