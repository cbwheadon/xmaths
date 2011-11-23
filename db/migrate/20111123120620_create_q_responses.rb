class CreateQResponses < ActiveRecord::Migration
  def change
    create_table :q_responses do |t|
      t.integer :q_time
      t.text :q_response

      t.timestamps
    end
  end
end
