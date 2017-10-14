class SeriesGenre < ApplicationRecord
  belongs_to :serie
  belongs_to :genre
end
