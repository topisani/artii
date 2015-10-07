class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :name
      t.text :description
      t.boolean :finished
      t.boolean :published
      t.timestamps
    end
  end
end
