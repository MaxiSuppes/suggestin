class AddCategoriesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :categories, :text, array: true, default: []
  end
end
