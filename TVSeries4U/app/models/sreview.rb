class Sreview < ApplicationRecord
  belongs_to :serie
  belongs_to :user

  # Validates
  validates :comment, presence: true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates_uniqueness_of :user, :scope => [:serie_id]
end
