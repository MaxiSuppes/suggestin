class CategoriesController < ApplicationController

  # GET /categories
  def index
    @user = current_user
  end

  def add_category
    @user = current_user
    current_user.categories << params[:new_category]
    @user.save
  end

  def delete_category
    @user = current_user
    current_user.categories.delete(params[:category_to_delete])
    @user.save
  end

end