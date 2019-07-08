class AddItemToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :item, :string
  end
end
