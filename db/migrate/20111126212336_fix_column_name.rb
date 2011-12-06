class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :posts, :adoption_id, :user_id
  end

  def down
  end
end
