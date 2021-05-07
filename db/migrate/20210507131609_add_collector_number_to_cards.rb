class AddCollectorNumberToCards < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :collector_number, :string
  end

  add_index :cards, [:set, :collector_number], unique: true
end
