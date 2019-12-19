class CreateTries < ActiveRecord::Migration[5.2]
  def change
    create_table :tries do |t|
      t.references :match, foreign_key: true
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
