class AddFoundToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :found, :boolean
  end
end
