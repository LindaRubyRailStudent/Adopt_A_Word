class Adoption < ActiveRecord::Base
belongs_to :user
belongs_to :word

  def adopt_a_word(word)
    @words << word
  end
end
