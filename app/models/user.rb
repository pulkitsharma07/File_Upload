class User < ApplicationRecord
  has_many :uploaded_files

  validates :name, presence: true, length: { minimum: 4, maximum: 10 }
  validates :username, presence: true, uniqueness: true, length: { maximum: 10 }

  has_secure_password

  validates :password, length: { minimum: 8 }
end
