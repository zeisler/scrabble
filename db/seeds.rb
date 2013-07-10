# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# File.readlines('db/dictionary.txt').each do |line|
#   Dictionary.create word: line
# end
# def transaction
# Dictionary.transaction do
#   1000.times do |i|
#     Dictionary.connection.execute "INSERT INTO Dictionary (word) values (#{i})"
#   end
# end

require('CSV')
blocks = []
index = 0
PATH = File.expand_path('')
CSV.foreach("#{PATH}/db/dictionary.csv") do |row|
  blocks << row[0]
  index += 1
end

block_count = ( blocks.count / 1000 ) + 1
block_count.times do |i|
   Dictionary.transaction do
     current = i * 1000
     1000.times do |trans_i|
       unless blocks[trans_i + current].nil?
         Dictionary.connection.execute "INSERT INTO Dictionaries ('word') values ('#{blocks[trans_i + current]}')"
       end
     end
   end
end

