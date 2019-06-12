class MainController < ApplicationController
  before_action :authenticate_user!,  :except => [:show_comments]
  # GET /main
  def index
    @user = current_user
    @user_url = url_for controller: 'comments', action: 'new', shop: @user.hash_for_url
  end

end