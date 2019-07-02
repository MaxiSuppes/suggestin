class ReportsController < ApplicationController

  # GET /reports
  def index
    @user = current_user
    @comments = current_user.comments
    @user_url = url_for controller: 'comments', action: 'new', shop: @user.hash_for_url
  end

  def get_comments_category
    @comments.select {|comment| comment.category == params[:category]}
  end

  def build_data_category(category_comments)
    [category_comments.select{|comment| comment.rating == 1}.count, category_comments.select{|comment| comment.rating == 2}.count,
     category_comments.select{|comment| comment.rating == 3}.count, category_comments.select{|comment| comment.rating == 4}.count,
     category_comments.select{|comment| comment.rating == 5}.count]
  end

  def generate_graphics_category(data_category)
    bar_colors = ['FFFF00']
    title = params[:category]
    legend = ['Cantidad de comentarios']
    axis_labels = ['1|2|3|4|5']

    @bar_chart_selected = Gchart.bar(
        :type => 'bar',
        :size => '600x400',
        :bar_colors => bar_colors,
        :title => title,
        :bg => 'EFEFEF',
        :legend => legend,
        :data => data_category,
        :axis_with_labels => [['x'], ['y']],
        :axis_range => [nil, [0, data_category.max]],
        :min_value => 0,
        :axis_labels => axis_labels,
        :bar_width_and_spacing => '25,60',
        )
  end

  def filter
    if params[:filter]
      index
      @category_comments = get_comments_category
      @data_category = build_data_category(@category_comments)
      generate_graphics_category(@data_category)
    end
  end

end