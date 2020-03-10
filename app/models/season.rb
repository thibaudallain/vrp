class Season < ApplicationRecord
  has_many :matches

  def to_csv
    player_headers = %w{promo first_name last_name capes_total essais_total}
    matches_headers = Match.where(season: self)
    matches_headers = matches_headers.map do |m|
      ["#{m.opponent}-#{m.date}"] + ["#{m.opponent}-#{m.date.strftime("%d/%m/%Y")}-tries"]
    end
    matches = Match.where(season: self).map { |m| [m] + [m] }.flatten
    matches = ["Promo", "Prénom", "Nom", "Capes", "Essais"] + matches

    selections_of_season = Match.where(season: self).map { |m| m.selections }.flatten
    tries_of_season = Match.where(season: self).map { |m|  m.tries }.flatten
    players_of_season = selections_of_season.map { |selection| selection.player }.uniq

    complete_headers = player_headers + matches_headers.flatten

    CSV.generate do |csv|
      csv << complete_headers
      players_of_season.each do |player|
        line_to_add = ["not set"] * matches.length
        matches.each_with_index do |m, i|
          if m == "Promo"
            line_to_add[i] = player.last_name
          elsif m == "Prénom"
            line_to_add[i] = player.first_name
          elsif m == "Nom"
            line_to_add[i] = player.promo
          elsif m == "Capes"
            line_to_add[i] = selections_of_season.select { |selection| selection.player == player }.length
          elsif m == "Essais"
            line_to_add[i] = tries_of_season.select { |try| try.player == player }.length
          elsif m.class == Match && line_to_add[i] == "not set"
            line_to_add[i] = Selection.where(player: player, match: matches[i]).length
            line_to_add[i + 1] = Try.where(player: player, match: matches[i]).length
          end
        end
        csv << line_to_add
      end
      # all.each do |user|
      #   csv << attributes.map{ |attr| user.send(attr) }
      # end
    end
  end
end
