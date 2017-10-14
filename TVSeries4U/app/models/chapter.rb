class Chapter < ApplicationRecord
  belongs_to :season

  # Validates
  validates :name, presence: true, length: { maximum: 50 }
  validates :number, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validates :length, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validates_uniqueness_of :number, :scope => [:season_id]

  # Reviews
  has_many :reviews, foreign_key: "chapter_id", class_name: "ChaptersReview", dependent: :destroy
  has_many :user_reviews, through: :reviews, source: :user
  
  # Seens
  has_many :viewed_chapter, dependent: :destroy
  has_many :seens, through: :viewed_chapter, source: :user

  def update_rating
    update_attributes(:rating => reviews.average("rating") || 0)
  end

  def saw_by?(user)
    seens.include?(user)
  end
end
