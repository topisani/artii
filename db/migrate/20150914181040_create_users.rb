class CreateUsers < ActiveRecord::Migration
  def change
    drop_table :users
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :encrypted_password
      t.string :salt

      t.timestamps
    end
  end
end
