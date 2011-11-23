class RemoveTableGames < ActiveRecord::Migration
  def up
  	drop_table :games
  	drop_table :papers
  end

  def down
  end
end
