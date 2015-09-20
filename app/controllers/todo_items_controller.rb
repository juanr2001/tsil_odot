class TodoItemsController < ApplicationController

    before_action :require_user
    before_action :find_todo_list

    def index
    end

    def new
        @todo_item = @todo_list.todo_items.new
    end

    def create
        @todo_item = @todo_list.todo_items.new( todo_item_params )

        if @todo_item.save
            flash[ :success ] = "Added todo list item."
            redirect_to todo_list_todo_items_path

        else
            flash[ :error ] = "There was a problem adding that todo item"
            render action: :new
        end
    end

    def edit
                                                                    #Fetch it with the 'id' bacause I am editing, not creating a new one.
        @todo_item = @todo_list.todo_items.find( params[ :id ] )
    end

    def update
        @todo_list = TodoList.find( params[ :todo_list_id ] )
        @todo_item = @todo_list.todo_items.find( params[ :id ] )

        if @todo_item.update_attributes(todo_item_params)
            flash[ :success ] = "Saved todo list item."
            redirect_to todo_list_todo_items_path

        else
            flash[ :error ] = "There was a problem adding that todo item"
            render action: :new
        end
    end

    def destroy
        @todo_item = @todo_list .todo_items.find( params[ :id ] )
        if @todo_item.destroy
            flash[ :success ] = "Todo list item was deleted."
        else
            flash[ :error ] = "Todo list item could not be deleted."
        end
        redirect_to todo_list_todo_items_path
    end

    def complete
        @todo_item = @todo_list.todo_items.find( params[ :id ] )
        #Time.now, will create a time of that exact moment when I press the button
        @todo_item.update_attribute( :completed_at, Time.now )
        redirect_to todo_list_todo_items_path, notice: "Todo item marked as complete."
    end

#This method will prevent me to write (@todo_list_id) in the controller and the view every time
#This will call the todo_list_id every time, so this will fetch it everytime it want a todo_item_id.
#That will put the todo_list_id param in every method in the controller.

    def url_options
                                                                #Everytime it generates a URL this will be call.
        { todo_list_id: params[ :todo_list_id ] }.merge( super )
    end

    private

    def find_todo_list
        @todo_list = current_user.todo_lists.find( params[ :todo_list_id ] )
    end

    def todo_item_params
        params[ :todo_item ].permit( :content )
    end

end
