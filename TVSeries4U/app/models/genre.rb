class Genre < ApplicationRecord
  # Series
  has_many :series_genres, dependent: :destroy
  has_many :series, through: :series_genres, source: :serie

  # Followers
  has_many :genres_relationship, dependent: :destroy
  has_many :followers, through: :genres_relationship, source: :user  

  # Validates
  validates_uniqueness_of :name
end
