class AddResponseIdToPlayground < ActiveRecord::Migration
  def change
    add_column :playgrounds, :q_response_id, :integer
  end
end
