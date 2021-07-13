class CreateGroceries < ActiveRecord::Migration[6.1]
  def change
    create_table :groceries do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :name
      t.decimal :amount, precision: 7, scale: 2
      t.string :unit

      t.timestamps
    end
  end
end
