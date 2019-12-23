class RemoveColumnFromPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :promo, :integer
  end
end
