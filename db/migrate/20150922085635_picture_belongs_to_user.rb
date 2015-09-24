class PictureBelongsToUser < ActiveRecord::Migration
  def change
    change_table :pictures do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.belongs_to :artwork
    end
  end
end
