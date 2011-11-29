class AddPlayerTypeToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :player_type, :integer
  end
end
