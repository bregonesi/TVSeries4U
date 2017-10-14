class CreateChaptersReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :chapters_reviews do |t|
      t.references :user, foreign_key: true
      t.references :chapter, foreign_key: true
      t.integer :rating, default: 0
      t.text :comment

      t.timestamps
    end
    add_index :chapters_reviews, :rating
    add_index :chapters_reviews, [:user_id, :chapter_id], unique: true
  end
end
