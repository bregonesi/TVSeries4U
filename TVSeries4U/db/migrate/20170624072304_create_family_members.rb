class CreateFamilyMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :family_members do |t|
      t.references :family, foreign_key: true
      t.references :user, foreign_key: true, index: { unique: true }
      t.boolean :parent

      t.timestamps
    end
    add_index :family_members, :parent
  end
end
