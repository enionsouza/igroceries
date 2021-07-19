class AddColumnToGroceries < ActiveRecord::Migration[6.1]
  def change
    add_column :groceries, :private, :boolean
  end
end
