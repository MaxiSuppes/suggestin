class ReportsController < ApplicationController

  # GET /reports
  def index
    @user = current_user
    @user_url = url_for controller: 'comments', action: 'new', shop: @user.hash_for_url
    @bar = Gchart.bar(:size => '200x300', :title => "example title", :bg => 'efefef', :legend => ['label 1', 'label 2'], :data => [10, 30])
  end
end
