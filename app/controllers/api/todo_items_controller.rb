class Api::TodoItemsController < ApplicationController

    protect_from_forgery
    skip_before_filter :verify_authenticity_token
    before_action :find_todo_list

    # -i \
    # -H "Accept: application/json" \
    # -H "Content-type: application/json" \
    # -X POST \
    # -d '{"content": "I have to do homeword"}' \
    # http://localhost:3000/api/todo_lists/9/todo_items
    def create
        item = @list.todo_items.new( item_params )
        if item.save
            render status: 200, json: {

                message: "Successfully created Todo Item.",
                todo_list: @list,
                todo_item: item

            }.to_json
        else
            render status: 422, json: {

                message: "Todo Item creation failed.",
                errors: item.errors

            }.to_json
        end
    end

    def update
        item = @list.todo_items.find( params[ :id ] )
        if item.update( item_params )
            render status: 200, json: {

                message: "Successfully Item updated.",
                todo_list: @list,
                todo_item: item

            }.to_json
        else
            render status: 422, json: {

                message: "This Item could not be updated",
                errors: item.errors

            }.to_json
        end
    end

    def destroy
        item = @list.todo_items.find( params[ :id ] )
        item.destroy
        render status: 200, json: {

            message: "Todo Item Successfully deleted.",
            todo_list: @list,
            todo_item: item

        }.to_json
    end

    private

    def item_params
        params.require( :todo_item ).permit( :content )
    end

    def find_todo_list
        @list = TodoList.find( params[ :todo_list_id ] )
    end

end