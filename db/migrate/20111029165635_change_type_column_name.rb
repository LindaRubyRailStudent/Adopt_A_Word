class ChangeTypeColumnName < ActiveRecord::Migration
def change
  rename_column :words, :type, :word_type
end
end
