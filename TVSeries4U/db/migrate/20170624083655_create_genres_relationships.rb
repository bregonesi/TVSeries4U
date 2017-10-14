class CreateGenresRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :genres_relationships do |t|
      t.references :genre, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :genres_relationships, [:genre_id, :user_id], unique: true
  end
end
