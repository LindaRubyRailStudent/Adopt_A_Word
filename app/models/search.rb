class Search < ActiveRecord::Base
  belongs_to :word

  def words(parameters)
    @words = find_words(parameters)
  end

  def find_words(parameters)
    #Word.find(:all, :conditions => conditions)
    Word.find(:all, :conditions => ["word like ?",parameters])

  end

  def keyword_conditions
    ["words.word LIKE ?", "%#{keywords}%"]unless keywords.blank?
  end

#  def category_conditions
#    ["words.category = ?", category] unless category.blank?
#  end

  def category_conditions
    ["words.category LIKE ?", "%#{category}"]
  end
  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map{ |condition| condition.first}
  end
  def conditions_options
    conditions_parts.map{|condition| condition[1..-1]}.flatten
  end
  def conditions_parts
    methods.grep(/_conditions$/).map { |m| send(m)}.compact
  end

end

