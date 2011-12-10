class Post < ActiveRecord::Base
  ## a post belongs to a user
  belongs_to :user
end
