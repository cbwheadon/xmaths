class AddPlaygroundIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :playground_id, :integer
  end
end
