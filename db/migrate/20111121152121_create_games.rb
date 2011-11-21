class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player1_id
      t.integer :player2_id
      t.integer :p1_correct
      t.integer :p2_correct
      t.integer :p1_time
      t.integer :p2_time
      t.integer :result

      t.timestamps
    end
  end
end
