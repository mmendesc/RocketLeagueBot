class IncreateIdLimite < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :telegram_id, :integer, limit: 8
  end
end
