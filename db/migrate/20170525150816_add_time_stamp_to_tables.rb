class AddTimeStampToTables < ActiveRecord::Migration[5.0]
  def change

    add_column(:stats, :created_at, :datetime)
    add_column(:stats, :updated_at, :datetime)

    add_column(:ranks, :created_at, :datetime)
    add_column(:ranks, :updated_at, :datetime)

  end
end
