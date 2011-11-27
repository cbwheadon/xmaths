class AddPlayerStateToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :state, :integer, default: 0
  end
end
