class SeasonsReview < ApplicationRecord
  belongs_to :user
  belongs_to :season

  # Validates
  validates :comment, presence: true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates_uniqueness_of :user, :scope => [:season_id]
end
