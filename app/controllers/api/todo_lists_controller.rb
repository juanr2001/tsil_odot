#inherets from api_controller.rb
class Api::TodoListsController < Api::ApiController

    # curl http://localhost:3000/api/todo_lists.json
    def index
        Rails.logger.info "Current user #{current_user.inspect}"
        render json: TodoList.all
    end
    # curl http://localhost:3000/api/todo_lists/2.json
    def show
        list = current_user.todo_lists.find( params[ :id ] )
        #this is a syntax for just one association
        render json: list.as_json( include: :todo_items )
        #to include more, use an array
        # render json: list.as_json( include:[ :todo_items ] )
    end

    def create
        list = current_user.todo_lists.new( list_params )
        if list.save
            render status: 200, json: {

                message: "Successfully created ToDo List.",
                todo_list: list

            }.to_json
        else
            render status: 422, json: {

                erros: list.errors

            }.to_json
        end
    end

    def update
        list = current_user.todo_lists.find( params[ :id ] )
        if list.update( list_params )
            render status: 200, json: {

                message: "Successfully updated",
                todo_list: list

            }.to_json
        else
            render status: 422, json: {

                message: "The Todo List could not be updated.",
                errors: item.errors

            }.to_json
        end
    end

    def destroy
        list = current_user.todo_lists.find( params[ :id ] )
        list.destroy
        render status: 200, json: {

            message: "Successfully delete Todo List."

        }.to_json

    end

    private

    def list_params
        params.require( :todo_list ).permit( :title )
    end

end


=begin
    Resources:

        CSRF http://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection.html
        Active Model Serialization - http://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html
        Active Model JSON Serializer - http://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html
        Common Status Error- https://tools.ietf.org/html/rfc4918#section-11.2
        Status Code Definitions - http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
        cURL - http://curl.haxx.se/docs/manpage.html

=end

=begin
    Steps to use Curl request
        terminam command = curl -i -H "Accept: application/json" -X POST -d '{"title": "The Title will be here"}' http://localhost:3000/api/todo_lists
        -i = include the header in the output so I can see what we get back from Rails
        -H = sends in the header
        "Accept: application.json" = I am sending a Header to accept JSON. Also I am telling Rails I will be sending JSON in the request body
        -H "Content-type: application/json" \
        -X = is the HTTP request type, which goes along with the different verbs (GET, DELET, PUT). Right now is a POST request
        -d = data (create something with data), which is the title
        CSRF =  cross site request forgery

        curl \ = back-slash will allow to do different lines that will be interpreted as one line
        > -i \
        > -H "Accept: application/json" \
        > -H "Content-type: application/json" \
        > -X POST \
        > -d '{"title":"The Title will go here"}' http://localhost:3000/api/todo_lists
=end