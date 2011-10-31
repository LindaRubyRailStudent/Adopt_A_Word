class AddUsageToWords < ActiveRecord::Migration
  def change
    add_column :words, :usage, :string
  end
end
