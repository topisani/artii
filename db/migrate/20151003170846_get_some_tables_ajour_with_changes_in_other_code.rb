class GetSomeTablesAjourWithChangesInOtherCode < ActiveRecord::Migration
  def change
    remove_column :pictures, :artwork_id, :integer
    remove_column :pictures, :post_id, :integer
    add_column :artworks, :user_id, :integer
    add_column :posts, :user_id, :integer
  end
end
