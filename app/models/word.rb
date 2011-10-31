class Word < ActiveRecord::Base
  belongs_to :adoption

def self.search(search)
  if search
    where('word LIKE ?', "%#{search}%")
  else
    scoped
  end
end
end
