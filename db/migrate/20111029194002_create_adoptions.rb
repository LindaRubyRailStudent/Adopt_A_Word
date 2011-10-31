class CreateAdoptions < ActiveRecord::Migration
  def change
    create_table :adoptions do |t|
      t.column :user_id, :integer
      t.column :adoption_id, :integer

      t.timestamps
    end
  end
end

