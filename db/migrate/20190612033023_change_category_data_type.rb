class ChangeCategoryDataType < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :category, :string
  end
end
