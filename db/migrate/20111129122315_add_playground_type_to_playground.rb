class AddPlaygroundTypeToPlayground < ActiveRecord::Migration
  def change
    add_column :playgrounds, :playground_type, :integer
  end
end
