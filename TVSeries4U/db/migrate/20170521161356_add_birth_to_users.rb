class AddBirthToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :birth, :date
    add_index :users, :birth
  end
end
