FactoryGirl.define do
  factory :user do
    first_name "First"
    last_name "Last"
    sequence(:email) { |n| "user#{n}@example.com" }
    password "blagsa"
    password_confirmation "blagsa"
  end

    factory :todo_list do
        title "Todo List Title"
        user
    end
end