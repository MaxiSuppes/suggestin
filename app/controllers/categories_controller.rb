class CategoriesController < ApplicationController

  # GET /categories
  def index
    @user = current_user
  end

  def add_category
    @user = current_user
  end

end