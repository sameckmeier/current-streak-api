class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end
