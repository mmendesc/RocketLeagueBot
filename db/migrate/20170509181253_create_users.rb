class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :telegram_id
      t.string :player_id
      t.string :platform
      t.string :first_name
      t.string :last_name
      t.integer :chat_id
      t.jsonb :bot_command, default: {}
      t.boolean :report, default: true

      t.timestamps

      t.index [:telegram_id,:chat_id], :unique => true
    end
  end
end
