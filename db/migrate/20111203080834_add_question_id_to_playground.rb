class AddQuestionIdToPlayground < ActiveRecord::Migration
  def change
    add_column :playgrounds, :question_id, :integer
  end
end
