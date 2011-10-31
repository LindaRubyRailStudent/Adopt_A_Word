class RenameColumnUserId < ActiveRecord::Migration
def change
  rename_column :adoptions, :adoption_id, :word_id
end
end
