require 'digest/sha1'
salt = BCrypt::Engine.generate_salt
encrypted_password = BCrypt::Engine.hash_secret(password, salt)