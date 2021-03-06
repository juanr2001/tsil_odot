class TodoList < ActiveRecord::Base

    #Associations
    has_many :todo_items
    belongs_to :user

    #Validations
    validates :title, presence: true
    validates :title, length: {minimum: 3}

#---- Calling the Scopes from the model  -----#
    def has_completed_items?
        todo_items.complete.size > 0
    end

    def has_incomplete_items?
        todo_items.incomplete.size > 0
    end
#----------------------------------------------------------#

end
