class Project < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_many :project_categories
  has_many :categories, through: :project_categories
  validates :title, presence: true, length: {minimum: 2, maximum: 200}
  validates :description, presence: true, length: {minimum: 10, maximum:10000}
  validates :user_id, presence: true
  acts_as_votable
end