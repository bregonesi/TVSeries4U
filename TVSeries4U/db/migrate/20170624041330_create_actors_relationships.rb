class CreateActorsRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :actors_relationships do |t|
      t.references :actor, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :actors_relationships, [:actor_id, :user_id], unique: true
  end
end
