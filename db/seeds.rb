# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'

Selection.destroy_all
Try.destroy_all
Match.destroy_all
Player.destroy_all
User.destroy_all
Season.destroy_all

anonyme = User.create(email: "anonyme@anonyme.fr", password: "anonyme")

csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
csv_options_2 = { col_sep: ';', quote_char: '"' }
filepath = "db/bdd.csv"

CSV.foreach(filepath, csv_options) do |row|
  row.nil?
  Player.create(promo: row['Pr'], first_name: row['Prénom'], last_name: row['Nom'], user: anonyme)
end

CSV.foreach(filepath, csv_options_2).with_index do |row, no|
  if no == 0
    iter = (0..row.length).to_a
    MATCH_ARRAY = (0..row.length).to_a
    iter.each do |iterator|
      unless row[iterator].nil?
        if row[iterator].include?("/")
          a = row[iterator].split("-").map { |e| e.strip }
          unless Season.where(start_year: a[2].split("/")[0]).length > 0
            season = Season.create(start_year: a[2].split("/")[0], end_year: a[1].split("/")[0])
          end
          season = Season.where(start_year: a[2].split("/")[0]).first
          match = Match.create(opponent: a[0], date: Date.new(a[1].split("/")[2].to_i, a[1].split("/")[1].to_i, a[1].split("/")[0].to_i), season: season)
          MATCH_ARRAY[iterator] = match
        end
      end
    end

  p MATCH_ARRAY

  else
    iter = (0..row.length).to_a
    iter.each do |iterator|
      if (row[iterator] == "1" || row[iterator] == "B" || row[iterator] == "T") && (MATCH_ARRAY[iterator].class == Match && !MATCH_ARRAY[iterator].opponent.include?("Essai"))
        puts "premier"
        puts "#{row[1]} #{row[2]}"
        puts row[iterator]
        puts MATCH_ARRAY[iterator]
        Selection.create!(player: Player.where(first_name: row[2], last_name: row[1]).first, match: MATCH_ARRAY[iterator])
      elsif !row[iterator].nil? && row[iterator].include?(",")
        row[iterator].split(",")[1].to_i.times do
          puts "deuxieme"
          puts row[iterator]
          puts "#{row[1]} #{row[2]}"
          puts MATCH_ARRAY[iterator]
          Try.create!(player: Player.where(first_name: row[2], last_name: row[1]).first, match: MATCH_ARRAY[iterator - 1])
        end
      elsif !row[iterator].nil? && MATCH_ARRAY[iterator].class == Match
        row[iterator][0].to_i.times do
          puts "troisieme"
          puts MATCH_ARRAY[iterator]
          puts row[iterator]
          puts "#{row[1]} #{row[2]}"
          Try.create!(player: Player.where(first_name: row[2], last_name: row[1]).first, match: MATCH_ARRAY[iterator - 1])
        end
      end
    end
  end
end



