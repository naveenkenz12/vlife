class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions, id: false do |t|
      t.string :q_id, null: false
      t.string :question_description, null: false
      t.timestamps
    end
    execute %Q{ ALTER TABLE "questions" ADD PRIMARY KEY("q_id");}
  end
end
