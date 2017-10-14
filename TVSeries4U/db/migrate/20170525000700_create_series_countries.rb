class CreateSeriesCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :series_countries do |t|
      t.references :serie, foreign_key: true
      t.references :country, foreign_key: true
    end
    add_index :series_countries, [:serie_id, :country_id], unique: true
  end
end
