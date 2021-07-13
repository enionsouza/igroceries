class CreateGroceriesGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groceries_groups, id: false do |t|
      t.belongs_to :group, index: true
      t.belongs_to :grocery, index: true

      t.timestamps
    end
  end
end
