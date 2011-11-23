class AddGameIdToPlayground < ActiveRecord::Migration
  def change
    add_column :playgrounds, :game_id, :integer
  end
end
