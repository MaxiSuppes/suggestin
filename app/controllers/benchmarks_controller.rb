class BenchmarksController < ApplicationController

  def index
    @categories = ["Gastronomia", "Hoteleria", "Kioscos",  "Shoppings", "Moda",  "Otro"]
    @ratings = [1, 2, 3, 4, 5]

    @user = current_user
    @comments = current_user.comments
    # @user_url = url_for controller: 'comments', action: 'new', shop: @user.hash_for_url
  end

  def compare
    @user = current_user
    @selected_category = params[:category]
      users_with_same_item = User.where(item: current_user.item)
      user_ids = users_with_same_item.pluck :id
      @comments = Comment.where(:user_id => user_ids)

      if @selected_category == "Todas"
        @global_score = calculate_average(@comments).round(2)
        @current_score = calculate_average(current_user.comments).round(2)
      else
        @comments = @comments.by_category(@selected_category)
        @global_score = calculate_average(@comments).round(2)
        @current_score = calculate_average(current_user.comments.by_category(@selected_category)).round(2)
      end

      @global_score_slider = @global_score * 100 /5.0
      @current_score_slider = @current_score * 100 /5.0
      @ranking = get_ranked_users users_with_same_item, @comments

  end

  def calculate_average comments
    if comments.size == 0
      return 0
    end
    comments.average(:rating)
  end

  def get_ranked_users users, comments
    ranked_users = []
    users.each do |u|
      average = calculate_average comments.where(user: u)
      ranked_users << {user: u, average: average.round(2), name: "Competencia"}
    end

    ranked_users = ranked_users.sort_by{|u| -u[:average]}

    current_user_index = ranked_users.index{|u| u[:user].id == current_user.id}
    ranked_users[current_user_index][:name] = current_user.name

    result = []

    case current_user_index
    when 0
      5.times do |i|
        ranked_users[current_user_index + i] ? result << ranked_users[current_user_index + i].merge({index: current_user_index + i + 1}) : nil
      end
      return result
    when 1
      5.times do |i|
        ranked_users[current_user_index - 1 + i] ? result << ranked_users[current_user_index - 1 + i].merge({index: current_user_index - 1 + i + 1}) : nil
      end
      return result
    when ranked_users.size - 2
      index = current_user_index - 3 + i
      if index > -1
        5.times do |i|
          ranked_users[index] ? result << ranked_users[index].merge({index: index + 1}) : nil
        end
      end
      return result
    when ranked_users.size - 1
      5.times do |i|
        index = current_user_index - 4 + i
        if index > -1
          ranked_users[index] ? result << ranked_users[index].merge({index: index + 1}) : nil
        end
      end
      return result
    else
      5.times do |i|
        result << ranked_users[current_user_index - 2 + i].merge({index: current_user_index - 2 + i + 1})
      end
      return result
    end
  end
end