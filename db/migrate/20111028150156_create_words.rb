class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.string :type
      t.string :time
      t.string :meaning

      t.timestamps
    end
  end
end
