class User < ActiveRecord::Base

    #validations
    validates :email, presence: true,
                                                uniqueness: true

    #callbacks to the models
    before_save( :downcase_email )

    def downcase_email
        self.email = email.downcase
    end


end
