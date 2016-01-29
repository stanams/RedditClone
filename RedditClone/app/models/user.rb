class User < ActiveRecord::Base
  validates :user_name, :password_digest, presence: true
  validates :user_name, :password_digest, uniqueness: true

  attr_reader: :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    user.is_password?(password) ? user : nil
  end


end
