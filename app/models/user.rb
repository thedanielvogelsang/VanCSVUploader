class User < ApplicationRecord
  has_secure_password
  has_many :user_surveys
  has_many :surveys, through: :user_surveys 
end
