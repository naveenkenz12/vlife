class UserInstitution < ApplicationRecord

	default_scope -> { order(start: :desc)}
end
