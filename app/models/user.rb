class User < ActiveRecord::Base

    #instance public methods api.rubyonrails.org
    has_secure_password

    #validations
    validates :email, presence: true,
                                                uniqueness: true,
                                                format: {
                                                    with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
                                                }

    #callbacks to the models
    before_save( :downcase_email )


    def downcase_email
        self.email = email.downcase
    end


end
