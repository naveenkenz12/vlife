class User < ActiveRecord::Base
	attr_accessor :remember_token, :reset_token
	before_save :lower_email
	after_save :clear_password

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.password = BCrypt::Engine.hash_secret(password, salt)
		end
	end

	def lower_email
		if email.present?
			self.email.downcase!
		end
	end

	def clear_password
		self.password = nil
	end

	self.primary_key = :u_id
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :u_id, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
	validates :email, :presence => true, length: { maximum: 255 }, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, :confirmation => true
	validates :phone_no, :presence => true, :uniqueness => true, :length => { :in => 10..10 }
	validates_length_of :password, :in => 8..20, :on => :create

	has_many :own_posts, :class_name => 'Post' ,dependent: :destroy , :foreign_key => "posted_by_id", :inverse_of => :posted_by
	
	has_one  :profile, :class_name => 'UserProfile', dependent: :destroy, :foreign_key => "u_id"
	
	# Returns the hash digest of the given string.
 	def User.digest(string)
		#cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :BCrypt::Engine.cost
		cost = 10
		BCrypt::Password.create(string, cost: cost)
	end

	#return a random token
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	#remember a user
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, user.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def password_reset_expired?
		reset_digest.nil? || reset_sent_at < 2.hours.ago
	end

	def profile_user?(other)
		self.u_id == other.u_id;
	end
end
