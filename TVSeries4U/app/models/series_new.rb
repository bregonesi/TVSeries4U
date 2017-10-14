class SeriesNew < ApplicationRecord
  belongs_to :user
  belongs_to :serie

  # Validates
  validates :title, presence: true
  validates :body, presence: true
end
