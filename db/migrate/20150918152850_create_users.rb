class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      #when g i wrote the column like...email:string:index
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
    add_index :users, :email
  end
end
