class Adoption < ActiveRecord::Base
belongs_to :user
has_many :words

  def adopt_a_word(word)
    @words << word
  end
end
