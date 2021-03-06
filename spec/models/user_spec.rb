require 'rails_helper'

RSpec.describe User, type: :model do
    describe User do

        let( :valid_attributes ) {
            {
                first_name: "Juan",
                last_name: "Ordaz",
                email: "juanordaz@gmail.com",
                password: "juan123",
                password_confirmation: "juan123"

            }
        }

        context "relationships" do
            it { should have_many( :todo_lists ) }
        end


        context "validations" do
            #this user is not save in the database yet.
            let( :user ) { User.new( valid_attributes ) }

            #Creating a user before all this start the last two test, to make sure everything is really there.
            before do
                User.create( valid_attributes )
            end

            it "requires an email" do
                expect( user ).to validate_presence_of( :email )
            end

            it "requires unique email" do
                expect( user ).to validate_uniqueness_of( :email )
            end

            it "requires a unique email (case insensitive)" do
                user.email = "JUANORDAZ@GMAIL"
                expect( user ).to validate_uniqueness_of( :email )
            end

            it "requires the email address to look like an email" do
            user.email = "juan"
            expect( user ).to_not be_valid
            end
        end

        #I can use context or describe when I test my methods.
        context "#downcase_email" do
            it "makes the email attribute lower case" do
                user = User.new( valid_attributes.merge( email: "JUANORDAZ@GMAIL.COM" ) )
                #---Other way I can write this test in one line in
                #user.downcase_email
                #expect( user.email ).to eq( "juanordaz@gmail.com" )
                expect{ user.downcase_email }.to change{ user.email }.
                from( "JUANORDAZ@GMAIL.COM" ).
                to( "juanordaz@gmail.com" )
                #----------------------------------------------------------------------
            end

            it "downcase an email before saving" do
                user = User.new( valid_attributes )
                user.email = "JUANORDAZ@GMAIL.COM"
                expect( user.save ).to be_truthy
                expect( user.email ).to eq( "juanordaz@gmail.com" )
            end
        end

        describe "#generate_password_reset_token!" do
            let( :user ) { create(:user ) }

            it "changes the password_reset_token attribute" do
                #use block to run the code, rather than just call it
                expect{ user.generate_password_reset_token! }.to change{ user.password_reset_token }
            end

            it "call SecureRandom.urlsafe_base64 to generate the password_reset_token" do
                expect( SecureRandom ).to receive( :urlsafe_base64 )
                user.generate_password_reset_token!
            end
        end
    end

    describe "#create_default_lists" do
        let( :user ) { create( :user ) }
        it "creates a todo list" do
            expect{ user.create_default_lists }.to change{ user.todo_lists.size }.by( 1 )
        end

        it "does not create the same todo list twice" do
            expect{ user.create_default_lists }.to change{ user.todo_lists.size }.by( 1 )
            expect{ user.create_default_lists }.to change{ user.todo_lists.size }.by( 0 )
        end

        it "create todo items" do
            expect{ user.create_default_lists }.to change{ TodoItem.count }.by( 7 )
        end

        it "create todo items only once" do
            expect{ user.create_default_lists }.to change{ TodoItem.count }.by( 7 )
            expect{ user.create_default_lists }.to change{ TodoItem.count }.by( 0 )
        end
    end

end
