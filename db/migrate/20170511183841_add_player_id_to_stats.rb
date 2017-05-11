class AddPlayerIdToStats < ActiveRecord::Migration[5.0]
  def change
    add_column :stats, :player_id, :string
  end
end
