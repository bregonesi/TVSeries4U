class AddUserToSerie < ActiveRecord::Migration[5.0]
  def change
    add_reference :series, :user, foreign_key: true
    add_column :series, :available, :integer
    add_index :series, :available
  end
end
