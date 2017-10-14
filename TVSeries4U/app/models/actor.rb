class Actor < ApplicationRecord
  # Series
  has_many :series_actors, dependent: :destroy
  has_many :series, through: :series_actors, source: :serie

  # Followers 
  has_many :actors_relationship, dependent: :destroy
  has_many :followers, through: :actors_relationship, source: :user  

  # News
  has_many :news, foreign_key: "actor_id", class_name: "ActorsNew", dependent: :destroy
  has_many :user_news, through: :news, source: :user
  
  # Validates
  validates :name, presence: true
  validates :last_name, presence: true
  validates_uniqueness_of :name, :scope => [:last_name], case_sensitive: false
  validates_uniqueness_of :last_name, :scope => [:name], case_sensitive: false

  def full_name
    "#{name} #{last_name}"
  end

  def self.search(search)
    where("name LIKE ? OR last_name LIKE ?", "%#{search}%", "%#{search}%") 
  end
end
