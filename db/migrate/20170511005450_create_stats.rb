class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats, force: true do |t|
      t.integer :wins
      t.integer :goals
      t.decimal :goal_ratio
      t.integer :saves
      t.integer :shots
      t.integer :assists
      t.integer :mvps
      t.integer :version
      t.integer :user_id
      t.boolean :played

    end
  end
end
