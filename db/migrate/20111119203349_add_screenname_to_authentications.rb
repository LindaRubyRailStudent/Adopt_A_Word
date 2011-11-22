class AddScreennameToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :screenname, :string
  end
end
