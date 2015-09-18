require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST 'create' " do
    context "with correct credentials" do
      #when I use the exclamation (" let! ") this code will run before any scenerio(tests) after it
      #If I don't have the exclamation sign, ruby will wait until it find the :user.
      let!( :user ) { User.create( first_name: "Juan", last_name: "Ordaz", email: "juanordaz@gmail.com", password: "password", password_confirmation: "password" ) }

      it "redirects to the todo list path" do
        post :create, email: "juanordaz@gmail.com", password: "password"
        expect(response).to be_redirect
        expect(response).to redirect_to( todo_lists_path )
      end

      it "find the user" do
        expect( User ).to receive( :find_by ).with( { email: "juanordaz@gmail.com" } ).and_return(user)
        post :create, email: "juanordaz@gmail.com", password: "password"
      end
      #I am using a feauture mocking and stubing
      it "authenticates the user" do
        #I have to create this user object eventhough I created before, bc is not the same object in memory
        #stubing new syntax
        #http://www.rubydoc.info/gems/rspec-mocks/frames
        allow(User).to receive_message_chain(:find_by).and_return(user)
        #create user object
        expect(user).to receive( :authenticate )

        #expect this user object recieves a authenticate method
        post :create, email: "juanordaz@gmail.com", password: "password"
      end
    end
  end
end
