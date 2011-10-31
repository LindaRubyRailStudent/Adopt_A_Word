class ChangeColumnName < ActiveRecord::Migration
def change
  rename_column :searches, :category_id, :category
end
end
