class User <ActiveRecord::Base
  has_many :projects
  before_save { self.username = username.downcase }
  before_save { self.email = email.downcase }
  validates :username, presence: true, uniqueness: { case_sensitive: false },
             length: {minimum:3, maximum:25}
  validates :full_name, presence: true,
             length: {minimum:3, maximum:50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
             length: {maximum: 100},
             uniqueness: {case_sensitive: false},
             format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
