class CreateRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :ranks do |t|
      t.string :playlist
      t.string :rank
      t.string :division
      t.integer :rating
      t.string :division_up
      t.string :division_down
      t.integer :games
      t.integer :user_id
      t.integer :version
      t.boolean :played
      t.string :player_id
    end
  end
end
