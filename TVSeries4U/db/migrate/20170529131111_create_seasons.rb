class CreateSeasons < ActiveRecord::Migration[5.0]
  def change
    create_table :seasons do |t|
      t.string :name
      t.integer :number
      t.references :serie, foreign_key: true
      t.text :description
      t.date :release
      t.integer :rating, default: 0

      t.timestamps
    end
    add_index :seasons, :number
    add_index :seasons, :release
    add_index :seasons, :rating
    add_index :seasons, [:serie_id, :number], unique: true
  end
end
