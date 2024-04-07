class CreateGameEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :game_events do |t|
      t.string :event_type, null: false
      t.datetime :occured_at, null: false
      t.references :user, null: false, foreign_key: true, index: true
      t.references :game, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
