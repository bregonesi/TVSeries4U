class GenresRelationship < ApplicationRecord
  belongs_to :genre
  belongs_to :user
end
