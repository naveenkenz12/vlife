class User < ActiveRecord::Base
	before_save :encrypt_password
	after_save :clear_password

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.password = BCrypt::Engine.hash_secret(password, salt)
		end
	end

	def clear_password
		self.password = nil
	end

	attr_accessor :u_id, :password, :password, :password_confirmation
	
	self.primary_key = :id
	#EMAIL_REGEX = /A[w+-.]+@[a-zd-.]+.[a-z]+z/i	
	validates :u_id, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates :email, :presence => true, :uniqueness => true#, :format => EMAIL_REGEX
	validates :password, :confirmation => true
	validates_length_of :password, :in => 8..20, :on => :create
end
