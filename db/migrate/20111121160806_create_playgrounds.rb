class CreatePlaygrounds < ActiveRecord::Migration
  def change
    create_table :playgrounds do |t|

      t.timestamps
    end
  end
end
