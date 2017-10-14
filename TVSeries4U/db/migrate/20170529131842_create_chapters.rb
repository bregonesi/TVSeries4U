class CreateChapters < ActiveRecord::Migration[5.0]
  def change
    create_table :chapters do |t|
      t.integer :number
      t.references :season, foreign_key: true
      t.string :name
      t.text :description
      t.date :release
      t.integer :length
      t.integer :rating, default: 0

      t.timestamps
    end
    add_index :chapters, :number
    add_index :chapters, :release
    add_index :chapters, :length
    add_index :chapters, :rating
    add_index :chapters, [:season_id, :number], unique: true
  end
end
