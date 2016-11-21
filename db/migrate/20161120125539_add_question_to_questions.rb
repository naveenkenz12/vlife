class AddQuestionToQuestions < ActiveRecord::Migration[5.0]
  def change
  end
  execute %Q{ insert into "questions" values('0','What is your hobby?',now(),now()); }
  execute %Q{ insert into "questions" values('1','Your opinion about me?',now(),now()); }

end
