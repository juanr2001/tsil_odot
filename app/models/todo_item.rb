class TodoItem < ActiveRecord::Base
    belongs_to :todo_list
    validates :content, presence: true,
                                                    length: { minimum: 2 }


    #I want to check when Items are complete or incomplete
    #So Whe I say todo_items.complete, it will look like this is the database
    #These are methods called that allows me to create a method for commonly used queries on models.
    scope :complete, -> { where( "completed_at is not null" ) } # in the database
    scope :incomplete, -> { where( completed_at: nil ) } #rails write this for me

    def completed?
        !completed_at.blank?
    end

end
