class AddRatingToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :rating, :integer
    add_column :comments, :category, :string
  end
end
