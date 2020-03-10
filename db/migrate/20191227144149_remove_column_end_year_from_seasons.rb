class RemoveColumnEndYearFromSeasons < ActiveRecord::Migration[5.2]
  def change
    remove_column :seasons, :end_year, :date
  end
end
