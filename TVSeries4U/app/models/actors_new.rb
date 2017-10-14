class ActorsNew < ApplicationRecord
  belongs_to :user
  belongs_to :actor

  # Validates
  validates :title, presence: true
  validates :body, presence: true
end
