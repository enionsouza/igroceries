class CreateGroceries < ActiveRecord::Migration[6.1]
  def change
    create_table :groceries do |t|
      t.references :author, index: {:unique=>true}, null: false, foreign_key: { to_table: :users }
      t.string :name
      t.decimal :amount, precision: 5, scale: 2
      t.string :unit

      t.timestamps
    end
  end
end
