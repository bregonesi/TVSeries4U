class CreateDirectorsRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :directors_relationships do |t|
      t.references :director, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :directors_relationships, [:director_id, :user_id], unique: true
  end
end
