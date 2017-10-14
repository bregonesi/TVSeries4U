class User < ApplicationRecord
  # Series
  has_many :series, dependent: :destroy

  # Family
  has_one :family_member, dependent: :destroy
  has_one :family, through: :family_member

  has_many :family_invites, dependent: :destroy
  has_many :family_invitations, through: :family_invites, source: :family

  # Follow users
  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # Follow things
  has_many :perfilseries, dependent: :destroy
  has_many :following_series, through: :perfilseries, source: :serie
  
  has_many :actors_relationship, dependent: :destroy
  has_many :following_actors, through: :actors_relationship, source: :actor

  has_many :directors_relationship, dependent: :destroy
  has_many :following_directors, through: :directors_relationship, source: :director

  has_many :genres_relationship, dependent: :destroy
  has_many :following_genres, through: :genres_relationship, source: :genre

  # Viewed things
  has_many :viewed_chapter, dependent: :destroy
  has_many :seen_chapters, through: :viewed_chapter, source: :chapter
  has_many :seen_seasons, -> { distinct }, through: :seen_chapters, source: :season
  has_many :seen_series, -> { distinct }, through: :seen_seasons, source: :serie
  
  # Reviews
  has_many :series_reviews, foreign_key: "user_id", class_name: "Sreview", dependent: :destroy
  has_many :seasons_reviews, dependent: :destroy
  has_many :chapters_reviews, dependent: :destroy

  # News
  has_many :series_news, dependent: :destroy
  has_many :actors_news, dependent: :destroy
  has_many :directors_news, dependent: :destroy
  
  # Validates
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Age of user
  def age
    (Date.today - self.birth).to_i / 365
  end

  # Follow users
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # Follow series
  def add_follow_serie(serie)
    following_series << serie
  end

  def del_follow_serie(serie)
    following_series.delete(serie)
  end

  def follow_serie?(serie)
    following_series.include?(serie)
  end

  # Follow actors
  def follow_actor(actor)
    following_actors << actor
  end

  def unfollow_actor(actor)
    following_actors.delete(actor)
  end

  def following_actor?(actor)
    following_actors.include?(actor)
  end

  # Follow directors
  def follow_director(director)
    following_directors << director
  end

  def unfollow_director(director)
    following_directors.delete(director)
  end

  def following_director?(director)
    following_directors.include?(director)
  end

  # Follow genres
  def follow_genre(genre)
    following_genres << genre
  end

  def unfollow_genre(genre)
    following_genres.delete(genre)
  end

  def following_genre?(genre)
    following_genres.include?(genre)
  end
  
  # Seens
  def saw_chapter?(chapter)
    seen_chapters.include?(chapter)
  end
  
  def add_saw_chapter(chapter)
    seen_chapters << chapter
  end

  def del_saw_chapter(chapter)
    seen_chapters.delete(chapter)
  end

  # Family
  def has_family?
    !family.nil?
  end

  def is_parent?
    family_member && family_member.parent?
  end

  def is_child?
    family_member && !family_member.parent?
  end

  def has_invites?
    !family_invitations.empty?
  end

  def is_invited?(family)
    family_invitations.include?(family)
  end
end
