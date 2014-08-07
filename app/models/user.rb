class User < ActiveRecord::Base
  has_many(
    :owned_subs,
    class_name: "Sub",
    foreign_key: :mod_id
  )

  has_many(
    :authored_posts,
    class_name: "Post",
    foreign_key: :author_id
  )
  
  has_many(
  )

  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  before_validation :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    user.is_password?(password) ? user : nil
  end

  def self.generate_token
    SecureRandom.urlsafe_base64
  end

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token
    self.session_token = self.class.generate_token
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_token
  end

end
