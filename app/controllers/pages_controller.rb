class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @players = Player.all
    @season = Season.first

    respond_to do |format|
      format.html
      format.csv { send_data @season.to_csv, filename: "players-#{Date.today}.csv" }
    end
  end
end
