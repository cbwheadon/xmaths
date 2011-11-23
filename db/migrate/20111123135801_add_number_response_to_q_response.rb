class AddNumberResponseToQResponse < ActiveRecord::Migration
  def change
    add_column :q_responses, :number_response, :decimal
  end
end
