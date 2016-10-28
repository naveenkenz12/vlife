class CreateSlamQuests < ActiveRecord::Migration[5.0]
  def change
    create_table :slam_quests do |t|
      t.string :slam_id, null: false
      t.string :q_id, null:false
      t.text :answer
      t.timestamps
    end
    add_index :slam_quests, :slam_id
    add_index :slam_quests, [:slam_id, :q_id], unique: true
    execute %Q{ ALTER TABLE "slam_quests" ADD FOREIGN KEY("slam_id") REFERENCES "slams"("slam_id"); }
    execute %Q{ ALTER TABLE "slam_quests" ADD FOREIGN KEY("q_id") REFERENCES "questions"("q_id"); }
  end
end
