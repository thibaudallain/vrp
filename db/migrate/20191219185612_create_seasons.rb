class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons do |t|
      t.date :start_year
      t.date :end_year
      t.string :result
      t.integer :won_count
      t.integer :lost_count
      t.integer :draw_count

      t.timestamps
    end
  end
end
