class Word < ActiveRecord::Base
  belongs_to :adoption
  has_many :searches

  #scope :funny, where('search == ?', true)
  #scope :general, lambda{where('published_at <= ?', Time.zone.now)}
  #scope :chain , funny.general.order('publised_at desc')

def self.search(search)
  if search
    where('word LIKE ?', "%#{search}%")
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
