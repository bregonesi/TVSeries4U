class CreateSeriesGenres < ActiveRecord::Migration[5.0]
  def change
    create_table :series_genres do |t|
      t.references :serie, foreign_key: true
      t.references :genre, foreign_key: true
    end
    add_index :series_genres, [:serie_id, :genre_id], unique: true
  end
end
