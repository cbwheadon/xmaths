class AddGameIdToGamePlayer < ActiveRecord::Migration
  def change
    add_column :game_players, :game_id, :integer
  end
end
