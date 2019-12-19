class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :opponent
      t.integer :score_vrp
      t.integer :score_opponent
      t.string :won
      t.date :date
      t.string :type
      t.references :season

      t.timestamps
    end
  end
end
