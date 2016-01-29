class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :password_digest, null: false

      t.timestamps null: false
    end
    add_index :users, :user_name
    add_index :users, :password_digest
  end
end
