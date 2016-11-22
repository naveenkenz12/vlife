namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    i = 0
    mob = 1000000000    #start with 10 digits
    User.populate 5 do |user|
      user.u_id = "#{'username'}#{i}"
      user.email   = "#{'username'}#{i}#{'@email.com'}"
      user.phone_no   = mob
      user.status = true
      user.password_digest = User.new(:password => "password").password_digest
      i = i+1
      mob = mob+1
      UserProfile.populate 1 do |up|
        up.u_id = user.u_id
        up.first_name = Faker::Name.first_name
        up.middle_name = Faker::Name.first_name
        up.last_name = Faker::Name.last_name
        up.gender = ['M','F','O']
        up.language = ['English', 'Hindi', 'French']
        up.birthday = "1996-04-17"
        up.rel_status = "Single"
        up.privacy = "O"
      end
      User.populate 5 do |fr|
        fr.u_id = "#{'username'}#{i}"
        fr.email   = "#{'username'}#{i}#{'@email.com'}"
        fr.phone_no   = Faker::Number.number(10)
        fr.status = true
        fr.password_digest = User.new(:password => "password").password_digest
        i = i +1
        mob = mob+1
        UserProfile.populate 1 do |up|
          up.u_id = fr.u_id
          up.first_name = Faker::Name.first_name
          up.middle_name = Faker::Name.first_name
          up.last_name = Faker::Name.last_name
          up.gender = ['M','F','O']
          up.language = ['English', 'Hindi', 'French']
          up.birthday = "1996-04-17"
          up.rel_status = "Single"
          up.privacy = "O"
        end
        Friend.populate 1 do |f|
          f.user_id = user.u_id
          f.friend_id = fr.u_id
          f.status = ['waiting', 'following', 'accepted']
        end        
      end
    end

    i = Post.count
    Post.populate 50 do |p|
      p.p_id = i.to_s(36)
      p.content = Populator.sentences(2..10)
      by = Random.rand(0..24)
      x = Random.rand(0..5)
      if x>=4
        to = Random.rand(0..24)
        p.posted_to_id = "#{'username'}#{to}"
      end
      p.posted_by_id = "#{'username'}#{by}"
      ran = Random.rand(0..2)
      if i>0
        if ran==2
          p.parent_id = Random.rand(0..i-1).to_s(36)
        end
      end
      i = i+1
    end

  end
end