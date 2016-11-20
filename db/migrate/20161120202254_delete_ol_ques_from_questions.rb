class DeleteOlQuesFromQuestions < ActiveRecord::Migration[5.0]
  def change
  end
  execute %Q{ DELETE FROM "slams" ;}
  execute %Q{ DELETE FROM "slam_quests" ;}
  execute %Q{ DELETE FROM "questions" ;}

end
