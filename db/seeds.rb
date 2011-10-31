# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Word.delete_all
open('words.csv') do |words|
  words.read.each_line do |part|
    word, type, time, meaning, usage = part.chomp.split(',')
    Word.create!(:word => word, :type => type, :time => time, :meaning => meaning, :usage => usage )
  end
end
