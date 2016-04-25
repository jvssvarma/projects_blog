class Category < ActiveRecord::Base

	has_many :project_categories
	has_many :projects, through: :project_categories 	
	validates :name, presence: true, length: {minimum: 2, maximum: 30}
	validates_uniqueness_of :name

end