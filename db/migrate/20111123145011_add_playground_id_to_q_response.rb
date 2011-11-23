class AddPlaygroundIdToQResponse < ActiveRecord::Migration
  def change
    add_column :q_responses, :playground_id, :integer
  end
end
