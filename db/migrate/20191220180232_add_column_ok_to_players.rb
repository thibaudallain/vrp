class AddColumnOkToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :promo, :string
  end
end
