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

	attr_accessor :password
	
	self.primary_key = :u_id
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :u_id, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates :email, :presence => true, length: { maximum: 255 }, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, :confirmation => true
	validates :phone_no, :presence => true, :uniqueness => true, :length => { :in => 10..10 }
	validates_length_of :password, :in => 8..20, :on => :create

	#attr_accessible :u_id, :password, :password_confirmation, :email, :phone_no
end
