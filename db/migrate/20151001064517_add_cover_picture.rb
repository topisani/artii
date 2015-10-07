class AddCoverPicture < ActiveRecord::Migration
  def change
    add_column :users, :cover_picture_id, :integer
    remove_column :users, :avatar, :integer
    remove_column :users, :picture_id, :integer
  end
end
