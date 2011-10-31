class AddAdoptionIdtoUser < ActiveRecord::Migration
  def change
    add_column :users, :adoption_id, :integer
  end
end
