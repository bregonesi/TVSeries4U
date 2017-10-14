class CreateSeriesDirectors < ActiveRecord::Migration[5.0]
  def change
    create_table :series_directors do |t|
      t.references :serie, foreign_key: true
      t.references :director, foreign_key: true
    end
    add_index :series_directors, [:serie_id, :director_id], unique: true
  end
end
