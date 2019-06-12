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
    @otras = @comments.select {|comment| comment.category == "Otras"}

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

    @dataotras= [@otras.select{|comment| comment.rating == 1}.count, @otras.select{|comment| comment.rating == 2}.count,
                      @otras.select{|comment| comment.rating == 3}.count, @otras.select{|comment| comment.rating == 4}.count,
                      @otras.select{|comment| comment.rating == 5}.count]

    @bar_chart_atencionalcliente = Gchart.bar(
        :type => 'bar',
        :size => '600x400',
        :bar_colors => ['0000FF'],
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
        :bar_colors => ['00FF00'],
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

    @bar_chart_seguridad = Gchart.bar(
        :type => 'bar',
        :size => '600x400',
        :bar_colors => ['FF0000'],
        :title => "Seguridad",
        :bg => 'EFEFEF',
        :legend => ['Cantidad de comentarios'],
        :data => [@dataseguridad],
        :axis_with_labels => [['x'], ['y']],
        :axis_range => [nil, [0, @dataseguridad.max]],
        :min_value => 0,
        :axis_labels => ['1|2|3|4|5'],
        :stacked => false,
        )

    @bar_chart_ubicacion = Gchart.bar(
        :type => 'bar',
        :size => '600x400',
        :bar_colors => ['000000'],
        :title => "Ubicación",
        :bg => 'EFEFEF',
        :legend => ['Cantidad de comentarios'],
        :data => [@dataubicacion],
        :axis_with_labels => [['x'], ['y']],
        :axis_range => [nil, [0, @dataubicacion.max]],
        :min_value => 0,
        :axis_labels => ['1|2|3|4|5'],
        :stacked => false,
        )

    @bar_chart_otras = Gchart.bar(
        :type => 'bar',
        :size => '600x400',
        :bar_colors => ['FFFF00'],
        :title => "Otras",
        :bg => 'EFEFEF',
        :legend => ['Cantidad de comentarios'],
        :data => [@dataotras],
        :axis_with_labels => [['x'], ['y']],
        :axis_range => [nil, [0, @dataotras.max]],
        :min_value => 0,
        :axis_labels => ['1|2|3|4|5'],
        :stacked => false,
        )
  end
end
