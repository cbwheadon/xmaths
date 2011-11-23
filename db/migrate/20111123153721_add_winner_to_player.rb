class AddWinnerToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :winner, :integer
  end
end
