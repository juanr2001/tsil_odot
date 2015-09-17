module RailsDomIdHelper
#I am passing a model

    def dom_id_for (model)
        #rails has this method to identify what is what I am calling(Can be a todo item, todo list..)
        #So I can to be able to generate a particular "dom_id" (todo item 1, todo item 2, etc.)
        #I have to put it in an Array, because i need the "#" sign,
        [ "#", ActionView::RecordIdentifier.dom_id( model ) ].join
    end

end