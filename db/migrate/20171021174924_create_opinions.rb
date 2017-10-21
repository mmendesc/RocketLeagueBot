class CreateOpinions < ActiveRecord::Migration[5.0]
  def change
    create_table :opinions do |t|
      t.text :text
      t.integer :user_id
    end
  end
end
