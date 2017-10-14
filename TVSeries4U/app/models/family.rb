class Family < ApplicationRecord
	# Members
	has_many :family_members, dependent: :destroy
	has_many :users, through: :family_members

	has_many :family_members_parents, -> { where parent: true }, class_name: "FamilyMember", foreign_key: "family_id"
	has_many :parents, through: :family_members_parents, source: :user

	has_many :family_members_childs, -> { where parent: false }, class_name: "FamilyMember", foreign_key: "family_id"
	has_many :childs, through: :family_members_childs, source: :user

	# Invitations
	has_many :family_invites, dependent: :destroy
	has_many :invitations, through: :family_invites, source: :user

	# Series
	has_many :series, -> { where("series.available >= ?", 1) }, through: :users

  	# Validates
  	validates :name, presence: true

	def is_member?(user)
		users.include?(user)
	end

	def is_parent?(user)
		parents.include?(user)
	end

	def is_child?(user)
		childs.include?(user)
	end
end
