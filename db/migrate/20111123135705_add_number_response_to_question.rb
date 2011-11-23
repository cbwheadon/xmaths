class AddNumberResponseToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :number_response, :decimal
  end
end
