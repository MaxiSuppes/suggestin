class ReportsController < ApplicationController

  # GET /reports
  def index
    @user = current_user
    @comments = current_user.comments
    @user_url = url_for controller: 'comments', action: 'new', shop: @user.hash_for_url

    @banio = @comments.select {|comment| comment.category == "Baño"}
    @atencionalcliente = @comments.select {|comment| comment.category == "Atención al cliente"}
    @ubicacion = @comments.select {|comment| comment.category == "Ubicación"}
    @seguridad = @comments.select {|comment| comment.category == "Seguridad"}

    @bar_chart = Gchart.bar(
        :type => 'bar',
        :size => '600x400',
        :bar_colors => ['000000', '0088FF'],
        :title => "Atención al cliente",
        :bg => 'EFEFEF',
        :legend => ['Cantidad de comentarios'],
        :data => [@atencionalcliente.select{|comment| comment.rating == 1}.count, @atencionalcliente.select{|comment| comment.rating == 2}.count,
        @atencionalcliente.select{|comment| comment.rating == 3}.count, @atencionalcliente.select{|comment| comment.rating == 4}.count,
        @atencionalcliente.select{|comment| comment.rating == 5}.count],
        :legend_position => 'bottom',
        :axis_with_labels => [['Calificación'], ['Cantidad de comentarios']],
        :max_value => 3,
        :min_value => 0,
        :axis_labels => [["1|2|3|4|5"]],
        :stacked => false,
        )
  end
end
