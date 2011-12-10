class Word < ActiveRecord::Base
  ## Words belong to an adoption
  ## Users may have many adoptions
  ## Words may have many posts through adoptions

  belongs_to :adoption
  has_many :searches
  has_many :users, :through => :adoptions
  has_many :posts, :through => :adoptions


  ## search method with 3 paramaters passed to it
  ## the find method uses a get method and an sql query

def self.search(search, search2, search3)
  if search
    #where('word LIKE ?', "%#{search}%")
    find(:all, :conditions => ['word LIKE ? AND category LIKE ? AND word_type LIKE ?' ,"%#{search}%", "%#{search2[:category]}%", "%#{search3[:type]}%"])
    #else
  else
    scoped
  end
end

#  def self.search(search,search1, search2, search3)
#    if search
#      find(:all, :conditions => ['word LIKE ? OR category LIKE ?","%#{search}"])
#
#    end)
#    end
#  end


end
