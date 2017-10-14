class CreateViewedChapters < ActiveRecord::Migration[5.0]
  def change
    create_table :viewed_chapters do |t|
      t.references :chapter, foreign_key: true
      t.references :user, foreign_key: true
    end
    add_index :viewed_chapters, [:chapter_id, :user_id], unique: true
  end
end
