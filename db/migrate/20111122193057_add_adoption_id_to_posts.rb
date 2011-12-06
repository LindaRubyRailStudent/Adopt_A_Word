class AddAdoptionIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :adoption_id, :integer
  end
end
