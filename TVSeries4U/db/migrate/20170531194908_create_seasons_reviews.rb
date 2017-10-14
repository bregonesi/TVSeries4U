class CreateSeasonsReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :seasons_reviews do |t|
      t.references :user, foreign_key: true
      t.references :season, foreign_key: true
      t.integer :rating, default: 0
      t.text :comment

      t.timestamps
    end
    add_index :seasons_reviews, :rating
    add_index :seasons_reviews, [:user_id, :season_id], unique: true
  end
end
