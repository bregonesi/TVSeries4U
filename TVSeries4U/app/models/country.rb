class Country < ApplicationRecord
  # Series
  has_many :series_countries, dependent: :destroy
  has_many :series, through: :series_countries, source: :serie
end
