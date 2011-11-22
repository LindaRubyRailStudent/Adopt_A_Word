class Word < ActiveRecord::Base
  belongs_to :adoption
  has_many :searches
  has_many :users, :through => :adoptions

  #scope :funny, where('search == ?', true)
  #scope :general, lambda{where('published_at <= ?', Time.zone.now)}
  #scope :chain , funny.general.order('publised_at desc')

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
