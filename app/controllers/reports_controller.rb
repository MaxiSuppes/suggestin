class ReportsController < ApplicationController

  # GET /reports
  def index
    @user = current_user
    @comments = current_user.comments
    @user_url = url_for controller: 'comments', action: 'new', shop: @user.hash_for_url

    @limpieza = @comments.select {|comment| comment.category == "Limpieza"}
    @atencionalcliente = @comments.select {|comment| comment.category == "Atención al cliente"}
    @ubicacion = @comments.select {|comment| comment.category == "Ubicación"}
    @seguridad = @comments.select {|comment| comment.category == "Seguridad"}

    @dataatencionalcliente = [@atencionalcliente.select{|comment| comment.rating == 1}.count, @atencionalcliente.select{|comment| comment.rating == 2}.count,
                              @atencionalcliente.select{|comment| comment.rating == 3}.count, @atencionalcliente.select{|comment| comment.rating == 4}.count,
                              @atencionalcliente.select{|comment| comment.rating == 5}.count]

    @datalimpieza = [@limpieza.select{|comment| comment.rating == 1}.count, @limpieza.select{|comment| comment.rating == 2}.count,
                              @limpieza.select{|comment| comment.rating == 3}.count, @limpieza.select{|comment| comment.rating == 4}.count,
                              @limpieza.select{|comment| comment.rating == 5}.count]

    @dataubicacion = [@ubicacion.select{|comment| comment.rating == 1}.count, @ubicacion.select{|comment| comment.rating == 2}.count,
                              @ubicacion.select{|comment| comment.rating == 3}.count, @ubicacion.select{|comment| comment.rating == 4}.count,
                              @ubicacion.select{|comment| comment.rating == 5}.count]

    @dataseguridad = [@seguridad.select{|comment| comment.rating == 1}.count, @seguridad.select{|comment| comment.rating == 2}.count,
                      @seguridad.select{|comment| comment.rating == 3}.count, @seguridad.select{|comment| comment.rating == 4}.count,
                      @seguridad.select{|comment| comment.rating == 5}.count]

    @bar_chart_atencionalcliente = Gchart.bar(
        :type => 'bar',
        :size => '600x400',
        :bar_colors => ['000000', '0088FF'],
        :title => "Atención al cliente",
        :bg => 'EFEFEF',
        :legend => ['Cantidad de comentarios'],
        :data => [@dataatencionalcliente],
        :axis_with_labels => [['x'], ['y']],
        :axis_range => [nil, [0, @dataatencionalcliente.max]],
        :min_value => 0,
        :axis_labels => ['1|2|3|4|5'],
        :stacked => false,
        )

    @bar_chart_limpieza = Gchart.bar(
        :type => 'bar',
        :size => '600x400',
        :bar_colors => ['000000', '0088FF'],
        :title => "Limpieza",
        :bg => 'EFEFEF',
        :legend => ['Cantidad de comentarios'],
        :data => [@datalimpieza],
        :axis_with_labels => [['x'], ['y']],
        :axis_range => [nil, [0, @datalimpieza.max]],
        :min_value => 0,
        :axis_labels => ['1|2|3|4|5'],
        :stacked => false,
        )
  end
end
