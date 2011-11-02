class AddCatToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :cat, :string
  end
end
