class Adoption < ActiveRecord::Base
  ## an adoption belongs to a user
  ## an adoption belongs to a word
belongs_to :user
belongs_to :word

  def adopt_a_word(word)
    @words << word
  end
end
