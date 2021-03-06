class ReportsController < ApplicationController
  # GET /reports
  def index
    @user = current_user
    @categories = current_user.categories
    @ratings = [1, 2, 3, 4, 5]
  end

  def filter_comments_by_date
    start_date = params[:start_date]
    end_date = params[:end_date]

    if start_date.empty? && end_date.empty?
      @user.comments
    elsif start_date.empty?
      @user.comments.where("created_at <= :end_date", {end_date: end_date})
    elsif end_date.empty?
      @user.comments.where("created_at >= :start_date", {start_date: start_date})
    else
      @user.comments.where(created_at: (start_date)..end_date)
    end
  end

  def get_comments_category(category)
    @comments.select {|comment| comment.category == category}
  end

  def build_data_category(category_comments)
    [category_comments.select{|comment| comment.rating == 1}.count, category_comments.select{|comment| comment.rating == 2}.count,
     category_comments.select{|comment| comment.rating == 3}.count, category_comments.select{|comment| comment.rating == 4}.count,
     category_comments.select{|comment| comment.rating == 5}.count]
  end

  def build_categories_by_rating(number_rating)
    data = []
    @categories.each do |category|
      category = @comments.select{|comment| comment.rating == number_rating}.select {|comment| comment.category == category}.count
      data.push(category)
    end
    data
  end

  def build_all_categories
    data_all_categories = []
    @ratings.each do |rating|
      data_all_categories.push(build_categories_by_rating(rating))
    end
    data_all_categories
  end

  def calculate_range_max_category
    all_categories = []
    @categories.each do |category|
      all_categories.push(get_comments_category(category).count)
    end
    all_categories.max
  end


  def generate_graphics_category(data_category, is_all_categories)

    if is_all_categories
      bar_colors = ['CC0000', 'FF6600', 'FFCC00', '00FFFF', '00CC00']
      legend = ['1 estrella', '2 estrellas', '3 estrellas', '4 estrellas', '5 estrellas']
      title = "Comentarios agrupados por categoría"
      axis_labels = [@categories]
      max_range = calculate_range_max_category
      max_value = max_range
    else
      bar_colors = ['00CCCC']
      legend = ['Cantidad de comentarios']
      title = params[:category]
      axis_labels = ['1|2|3|4|5']
      max_range = data_category.max
      max_value = max_range.to_i + 5
    end

    @bar_chart_selected = Gchart.bar(
        :type => 'bar',
        :size => '600x400',
        :bar_colors => bar_colors,
        :title => title,
        :bg => 'EFEFEF',
        :legend => legend,
        :data => data_category,
        :axis_with_labels => [['x'], ['y']],
        :axis_range => [nil, [0, max_range, 1]],
        :max_value => max_value,
        :min_value => 0,
        :axis_labels => axis_labels,
        :bar_width_and_spacing => '25,60',
        )
  end

  def filter
    if params[:filter]
      index
      @comments = filter_comments_by_date
      is_all_categories = false
      @selected_category = params[:category]
      if params[:category] != "Todas"
        comments_category = get_comments_category(params[:category])
        data_category = build_data_category(comments_category)
      else
        is_all_categories = true
        data_category = build_all_categories
      end
      generate_graphics_category(data_category, is_all_categories)
    end
  end
end