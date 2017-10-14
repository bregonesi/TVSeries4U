class Perfilserie < ApplicationRecord
  belongs_to :serie
  belongs_to :user

  # Validates
  validates_uniqueness_of :user, :scope => [:serie]
end
