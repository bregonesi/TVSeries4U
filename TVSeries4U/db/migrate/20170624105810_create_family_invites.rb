class CreateFamilyInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :family_invites do |t|
      t.references :family, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :parent

      t.timestamps
    end
    add_index :family_invites, [:family_id, :user_id], unique: true
  end
end
