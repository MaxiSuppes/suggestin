class CommentsController < ApplicationController
  #before_action :authenticate_user!,  :except => [:new, :create, :comment_success, :new_whit_shop_name, :comment_error]

  # GET /comments
  def index
    @user = current_user
    @comments = current_user.comments.order('created_at desc')
    @user_url = url_for controller: 'comments', action: 'new', shop: current_user.hash_for_url
  end

  # GET /comments/1
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  def new
    @user = User.find_by_hash_for_url(params[:shop])
    if @user.nil?
      respond_to do |format|
        flash[:error] = "Verifique el nombre del comercio"
        format.html { redirect_to action: 'comment_error'}
      end
    end
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @user = User.find(@comment.user_id)

    respond_to do |format|
      if @comment.save
        send_notification_to(@comment.user_id, @comment)

        flash[:success] = "Recibimos tu comentario. ¡Gracias!"
        format.html { redirect_to action: 'comment_success'}
      else
        flash[:error] = "El campo de comentario no puede estar en blanco"
        format.html { redirect_to action: 'new' , shop: @user.hash_for_url}
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash[:success] = "El comentario se borró correctamente"
      format.html { redirect_to comments_url}
    end
  end

  def new_whit_shop_name
    @user = User.find_by_name(params[:shop_name].gsub('-', ' '))
    if @user.nil?
      respond_to do |format|
        flash[:error] = "Verifique el nombre del comercio"
        format.html { redirect_to action: 'comment_error'}
      end
    else
      redirect_to action: 'new', shop: @user.hash_for_url
    end
  end

  def comment_success
  end

  def comment_error
  end

  def filter
    if params[:filter]
      index
      @selected_category = params[:category]
      @start_date = params[:start_date_comment]
      @end_date = params[:end_date_comment]
      category = params[:category]
      if category != "Todas"
        @comments = filter_comments_category(category)
      end
      @comments = filter_comments_by_date
    end
  end

  private
  def send_notification_to(user_id, comment_data)
    @user = User.find(user_id)
    UserNotifierMailer.send_new_comment_notice(@user.email, comment_data.content, comment_data.name, comment_data.email).deliver
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :name, :email, :rating, :category, :image)
  end

  def filter_comments_category(category)
    @comments.where("category = :category", {category: category})
  end

  def filter_comments_by_date
    start_date = params[:start_date_comment]
    end_date = params[:end_date_comment]

    if start_date.empty? && end_date.empty?
      @comments
    elsif start_date.empty?
      @comments.where("created_at <= :end_date", {end_date: end_date})
    elsif end_date.empty?
      @comments.where("created_at >= :start_date", {start_date: start_date})
    else
      @comments.where(created_at: (start_date)..end_date)
    end
  end
end
