class TodoList < ActiveRecord::Base

    #Validations
    validates :title, presence: true
    validates :title, length: {minimum: 3}

end
