class SeriesSubtitle < ApplicationRecord
  belongs_to :serie
  belongs_to :language
end
