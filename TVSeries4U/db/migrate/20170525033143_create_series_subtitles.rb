class CreateSeriesSubtitles < ActiveRecord::Migration[5.0]
  def change
    create_table :series_subtitles do |t|
      t.references :serie, foreign_key: true
      t.references :language, foreign_key: true
    end
    add_index :series_subtitles, [:serie_id, :language_id], unique: true
  end
end
