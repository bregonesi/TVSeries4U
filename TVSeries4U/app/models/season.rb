class Season < ApplicationRecord
  belongs_to :serie

  # Validates
  validates :name, presence: true, length: { maximum: 50 }
  validates :number, presence: true, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validates_uniqueness_of :number, :scope => [:serie_id]

  # Chapters
  has_many :chapters, dependent: :destroy

  # Reviews
  has_many :reviews, foreign_key: "season_id", class_name: "SeasonsReview", dependent: :destroy
  has_many :user_reviews, through: :reviews, source: :user
  
  def update_rating
    update_attributes(:rating => reviews.average("rating"))
  end

  def saw_by?(user)  ## retorna 1 si no esta entera vista, 2 si se vio todo, 0 si no se ha visto nada
    any_seen = false
    any_not_seen = true
    chapters.each do |chapter|
      if chapter.saw_by?(user)
        any_seen = true
      else
        any_not_seen = false
      end

      if any_seen and not any_not_seen
        return 1
      end
    end

    if any_seen
      return 2
    end

    if not any_not_seen
      return 0
    end
  end
end
