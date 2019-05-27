class AddDataToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |table|
      table.string :name,                    null: false, default: ""
      table.string :hash_for_url,            null: false, default: ""
    end
    add_index :users, :name,                unique: true
    add_index :users, :hash_for_url,        unique: true
  end
end
