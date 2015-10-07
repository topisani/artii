class AddTestKeysToUser < ActiveRecord::Migration
  def change
    add_column :users, :picture_id, :integer
    remove_column :users, :avatar, :string
    add_column :users, :avatar, :integer
  end
end
