class CreateSeriesActors < ActiveRecord::Migration[5.0]
  def change
    create_table :series_actors do |t|
      t.references :serie, foreign_key: true
      t.references :actor, foreign_key: true
    end
    add_index :series_actors, [:serie_id, :actor_id], unique: true
  end
end
