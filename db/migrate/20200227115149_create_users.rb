class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.boolean :confirmed, default: false
      t.string :confirmation_token
      t.string :password_digest
      t.string :firstname
      t.string :lastname
      t.boolean :photo, default: false
      t.string :sport

      t.timestamps
    end
  end
end
