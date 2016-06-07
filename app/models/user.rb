class User <ActiveRecord::Base
  before_create :confirmation_token

  has_many :projects, dependent: :destroy
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

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
