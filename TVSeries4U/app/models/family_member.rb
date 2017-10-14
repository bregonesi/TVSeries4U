class FamilyMember < ApplicationRecord
  belongs_to :family
  belongs_to :user

  # Validates
  validates_uniqueness_of :user
end
