class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :oracle_id, null: false
      t.string :name, null: false
      t.string :set, null: false
      t.float :price_usd
      t.float :price_usd_foil
      t.float :price_eur
      t.float :price_eur_foil
      t.float :price_tix

      t.timestamps
    end

    change_column_default :cards, :created_at, from: nil, to: -> { 'current_timestamp' }
    change_column_default :cards, :updated_at, from: nil, to: -> { 'current_timestamp' }

    add_index :cards, :oracle_id, unique: true
    add_index :cards, [:name, :set], unique: true
  end
end
