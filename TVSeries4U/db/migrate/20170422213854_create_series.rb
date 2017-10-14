class CreateSeries < ActiveRecord::Migration[5.0]
  def change
    create_table :series do |t|
      t.string :title
      t.text :description
      t.string :rating, default: 0

      t.timestamps
    end
    add_index :series, :rating
  end
end
