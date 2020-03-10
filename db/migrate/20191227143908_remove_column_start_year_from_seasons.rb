class RemoveColumnStartYearFromSeasons < ActiveRecord::Migration[5.2]
  def change
    remove_column :seasons, :start_year, :date
  end
end
