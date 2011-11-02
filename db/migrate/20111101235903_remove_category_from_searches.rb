class RemoveCategoryFromSearches < ActiveRecord::Migration
  def up
    remove_column :searches, :category
  end

  def down
    add_column :searches, :category, :integer
  end
end
