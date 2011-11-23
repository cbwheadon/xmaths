class AddCorrectToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :correct, :integer
  end
end
