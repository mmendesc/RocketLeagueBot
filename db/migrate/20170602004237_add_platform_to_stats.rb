class AddPlatformToStats < ActiveRecord::Migration[5.0]
  def change
    add_column :stats, :platform, :string
  end
end
