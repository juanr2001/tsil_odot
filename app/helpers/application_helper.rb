module ApplicationHelper

    def title(title)
        content_for( :title ) {"#{title} | "}
        #This is the same as >>  <h2 class = "page-title truncate" title = "<%= @todo_list.title %>"><%= @todo_list.title%></h2>
        # same as >> <h1><%= @todo_list.title %> - Editing Todo List Item</h1>
        #same as >> <h2 class = "page-title">Todo Lists</h2>
        #same as >> <h1>Editing Todo List</h1>
        #same as >> <h1>New Todo List</h1>
        #this is call in todo_items/index, edit, new,
        #This is call in todo_list/index,show, new, edit
        content_tag( :h2, title, class: "page-title truncate", title: title )
    end

    def new_item_link
        # <a href="#" class = "icon-new right hide-text">Add Item</a>
        if @todo_list && !@todo_list.new_record?
            text, path = "Todo Item", new_todo_list_todo_item_path( @todo_list )
        else
            text, path = "Todo List", new_todo_list_path
        end
        link_to "Add #{text}", path, class: "icon-new right hide-text"
    end

end
