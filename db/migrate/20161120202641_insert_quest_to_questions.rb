class InsertQuestToQuestions < ActiveRecord::Migration[5.0]
  def change
  end
  execute %Q{ insert into "questions" values('0','Hobbies...',now(),now() ) ;}
  execute %Q{ insert into "questions" values('1','You aspire to become...',now(),now() ) ;}
  execute %Q{ insert into "questions" values('2','Few words that define you...',now(),now() ) ;}
  execute %Q{ insert into "questions" values('3','Your opinion about me...',now(),now() ) ;}
  execute %Q{ insert into "questions" values('4','Your opinion about life...',now(),now() ) ;}
  execute %Q{ insert into "questions" values('5','Your opinion about love...',now(),now() ) ;}
  execute %Q{ insert into "questions" values('6','Your ideal in life...',now(),now() ) ;}
  execute %Q{ insert into "questions" values('7','One thing you cannot live without...',now(),now() ) ;}
  execute %Q{ insert into "questions" values('8','Your opinion on destiny...',now(),now() ) ;}
  execute %Q{ insert into "questions" values('9','If you won the lottery, what would you do...',now(),now() ) ;}
  execute %Q{ insert into "questions" values('a','Any secret crush...',now(),now() ) ;}
  execute %Q{ insert into "questions" values('b','If you could meet one person, dead or alive, who would it be...',now(),now() ) ;}

end
