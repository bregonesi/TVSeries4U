class SeriesCountry < ApplicationRecord
  belongs_to :serie
  belongs_to :country
end
