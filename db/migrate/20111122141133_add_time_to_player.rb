class AddTimeToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :time, :integer
  end
end
