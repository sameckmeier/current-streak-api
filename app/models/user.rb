class User < ApplicationRecord
    has_secure_password
    
    validates :email, :username, uniqueness: true
    validates :email, :username, full_name, presence: true
end
