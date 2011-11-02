class AddCategoryToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :category, :string
  end
end
