class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.string :text
      t.string :createdat
      t.string :name
      t.string :screenname

      t.timestamps
    end
  end
end
