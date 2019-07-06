class AddProductsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :has_reports, :boolean, default: false
    add_column :users, :has_benchmark, :boolean, default: false
  end
end
