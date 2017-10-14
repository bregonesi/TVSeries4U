class CreatePerfilseries < ActiveRecord::Migration[5.0]
  def change
    create_table :perfilseries do |t|
      t.references :serie, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :perfilseries, [:serie_id, :user_id], unique: true
  end
end
