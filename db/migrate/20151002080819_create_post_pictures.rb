class CreatePostPictures < ActiveRecord::Migration
  def change
    create_table :post_pictures do |t|
      t.integer :post_id
      t.integer :picture_id

      t.timestamps
    end
  end
end
