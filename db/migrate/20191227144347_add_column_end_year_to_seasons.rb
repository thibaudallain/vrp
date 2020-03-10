class AddColumnEndYearToSeasons < ActiveRecord::Migration[5.2]
  def change
    add_column :seasons, :end_year, :integer
  end
end
