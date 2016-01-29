class User < ActiveRecord::Base
  validates :user_name, :password_digest, presence: true
  validates :user_name, :password_digest, uniqueness: true
  validates :password, length: {minimum: 6}, allow_nil: true

  before_validation :ensure_session_token

  attr_reader :password

  has_many(
    :subs,
    foreign_key: :moderator_id,
    class_name: 'Sub'
  )

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    user && user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

end
