class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.integer :games
      t.integer :wins
      t.integer :inarow

      t.timestamps
    end
  end
end
