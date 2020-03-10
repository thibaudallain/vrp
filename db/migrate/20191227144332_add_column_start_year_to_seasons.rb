class AddColumnStartYearToSeasons < ActiveRecord::Migration[5.2]
  def change
    add_column :seasons, :start_year, :integer
  end
end
