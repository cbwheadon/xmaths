class AddNumberResponseToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :number_response, :decimal
  end
end
