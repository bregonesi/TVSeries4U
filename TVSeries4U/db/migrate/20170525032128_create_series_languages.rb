class CreateSeriesLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :series_languages do |t|
      t.references :serie, foreign_key: true
      t.references :language, foreign_key: true
    end
    add_index :series_languages, [:serie_id, :language_id], unique: true
  end
end
