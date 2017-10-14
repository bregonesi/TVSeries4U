class AddAgeToSerie < ActiveRecord::Migration[5.0]
  def change
    add_column :series, :age, :integer
    add_index :series, :age
  end
end
