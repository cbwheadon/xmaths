class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :stimulus
      t.string :image_url
      t.integer :param1
      t.integer :param2
      t.integer :answer

      t.timestamps
    end
  end
end
