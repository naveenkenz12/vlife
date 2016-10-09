class User < ActiveRecord::Base
	attr_accessor :password
	EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
	validates :u_id, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
end
