require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

    describe PasswordResetsController do
        describe "GET new" do
            it "render the new template" do
                get :new
                expect( response ).to render_template( "new" )
            end
        end

        describe "POST create" do
            context "with a valid user and email" do
                let( :user ) { create (:user ) }

                it "finds the user" do
                    expect( User ).to receive( :find_by ).with(email: user.email).and_return( user )
                    post :create, email: user.email
                end

                it "generate a new password reset toke" do
                    expect { post :create, email: user.email; user.reload }.to change{ user.password_reset_token }
                end

                it "sends a password reset email" do
                    expect{ post :create, email: user.email }.to change( ActionMailer::Base.deliveries, :size )
                end

                it "sets the flash success message" do
                    post :create, email: user.email
                    expect( flash[ :success ] ).to match( /check your email/ )
                end
            end

            context "with no user found" do
                it "renders the new page" do
                    post :create, email: 'blahh@google.com'
                    expect( response ).to render_template( 'new' )
                end

                it "sets the falsh message" do
                    post :create, email: "blahh@google.com"
                    expect( flash[ :notice ] ).to match(/not found/)
                end
            end
        end
    end

end
