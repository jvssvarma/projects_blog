class Project < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: {minimum: 2, maximum: 50}
  validates :description, presence: true, length: {minimum: 10, maximum:600}
  validates :user_id, presence: true
end