require 'rails_helper'
#Now I have to specify what I am testing with RSpec...
RSpec.feature "User", :type => :feature do
    describe "Forgotten password" do
        let!( :user ) { create(:user ) }
    end


end