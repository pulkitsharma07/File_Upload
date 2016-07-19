class User < ApplicationRecord
  has_many :uploaded_files

  has_secure_password
end
