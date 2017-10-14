class DirectorsNew < ApplicationRecord
  belongs_to :user
  belongs_to :director

  # Validates
  validates :title, presence: true
  validates :body, presence: true
end
