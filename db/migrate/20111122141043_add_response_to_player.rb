class AddResponseToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :response, :text
  end
end
