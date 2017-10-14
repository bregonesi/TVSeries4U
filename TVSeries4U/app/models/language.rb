class Language < ApplicationRecord
  # Series
  has_many :series_languages, dependent: :destroy
  has_many :series_audio, through: :series_languages, source: :serie

  has_many :series_subtitles, dependent: :destroy
  has_many :series_sub, through: :series_subtitles, source: :serie
end
