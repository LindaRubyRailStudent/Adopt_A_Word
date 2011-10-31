class CreateWordies < ActiveRecord::Migration
  def change
    create_table :wordies do |t|

      t.timestamps
    end
  end
end
