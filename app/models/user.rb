class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :histories

  validates :full_name, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 105 },
            format: { with: VALID_EMAIL_REGEX }
  validates :slack_register_id, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 6, maximum: 6 }
  # validates :slack_id, presence: true,
  #           uniqueness: { case_sensitive: false }
  has_secure_password
end
