class Serie < ApplicationRecord
  belongs_to :user

  # Files
  has_attached_file :serie_image, default_url: "/images/:style/missing.png"

  # Followers
  has_many :perfilseries, dependent: :destroy
  has_many :followers, :through => :perfilseries, source: :users

  # Genres
  has_many :series_genres, dependent: :destroy
  has_many :genres, through: :series_genres

  # Countries
  has_many :series_countries, dependent: :destroy
  has_many :countries, through: :series_countries

  # Languages
  has_many :series_languages, dependent: :destroy
  has_many :languages, through: :series_languages

  # Subtitles
  has_many :series_subtitle, dependent: :destroy
  has_many :subtitles, through: :series_subtitle, source: :language

  # Actors
  has_many :series_actors, dependent: :destroy
  has_many :actors, through: :series_actors

  # Directors
  has_many :series_directors, dependent: :destroy
  has_many :directors, through: :series_directors

  # Seasons and chapters
  has_many :seasons, dependent: :destroy
  has_many :chapters, through: :seasons

  # Reviews
  has_many :reviews, foreign_key: "serie_id", class_name: "Sreview", dependent: :destroy
  has_many :user_reviews, through: :reviews, source: :user

  # News
  has_many :news, foreign_key: "serie_id", class_name: "SeriesNew", dependent: :destroy
  has_many :user_news, through: :news, source: :user

  # Validates
  validates :title, presence: true
  validates :description, presence: true
  validates :age, presence: true
  validates :available, presence: true
  validates_attachment_content_type :serie_image, content_type: /\Aimage\/.*\z/, presence: true

  def self.search(search)
    where("title LIKE ?", "%#{search}%") 
  end

  def can_edit(user)
    user && user.age >= age && (user.admin? or self.user == user or (available == 1 && user.has_family? && user.family.is_member?(self.user)))
  end

  def update_rating
    update_attributes(:rating => reviews.average("rating") || 0)
  end

  def saw_by?(user)  ## retorna 1 si no esta entera vista, 2 si se vio todo, 0 si no se ha visto nada
    any_seen = false
    any_not_seen = true
    seasons.each do |season|
      if season.saw_by?(user) == 2
        any_seen = true
      elsif season.saw_by?(user) == 0
        any_not_seen = false
      end

      if (any_seen and not any_not_seen) or season.saw_by?(user) == 1
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

  def self.all_series_user(user)
    if user
      if user.has_family?
        where("series.age <= ?", user.age).where("series.available = 2 OR
          (series.available >= 1 AND series.user_id IN (SELECT family_members.user_id FROM family_members WHERE family_id = ?)) OR
          (series.available = 0 AND series.user_id = ?)", user.family.id, user.id)
      else
        where("series.age <= ?", user.age).where("series.available = 2 OR
          (series.available = 0 AND series.user_id = ?)", user.id)
      end
    else
      where("series.age < 18 AND series.available = 2")
    end
  end
end
