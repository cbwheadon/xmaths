class RemoveQuestionIdFromPlayground < ActiveRecord::Migration
  def up
    remove_column :playgrounds, :question_id
  end

  def down
    add_column :playgrounds, :question_id, :integer
  end
end
