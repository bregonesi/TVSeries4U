class CreateSreviews < ActiveRecord::Migration[5.0]
  def change
    create_table :sreviews do |t|
      t.references :user, foreign_key: true
      t.references :serie, foreign_key: true
      t.integer :rating, default: 0
      t.text :comment

      t.timestamps
    end
    add_index :sreviews, :rating
    add_index :sreviews, [:user_id, :serie_id], unique: true
  end
end
