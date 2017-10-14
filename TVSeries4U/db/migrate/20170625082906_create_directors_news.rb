class CreateDirectorsNews < ActiveRecord::Migration[5.0]
  def change
    create_table :directors_news do |t|
      t.references :user, foreign_key: true
      t.references :director, foreign_key: true
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
