class CreateArtworkPictures < ActiveRecord::Migration
  def change
    create_table :artwork_pictures do |t|
      t.integer :artwork_id
      t.integer :picture_id

      t.timestamps
    end
  end
end
