class FamilyInvite < ApplicationRecord
  belongs_to :family
  belongs_to :user

  # Validates
  validates_uniqueness_of :user, :scope => [:family]
end
