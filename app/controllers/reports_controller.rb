class ReportsController < ApplicationController

  # GET /reports
  def index
    @user = current_user
    @comments = current_user.comments
    @user_url = url_for controller: 'comments', action: 'new', shop: @user.hash_for_url
  end

  def filter
    if params[:filter]

      @user = current_user
      @comments = current_user.comments
      @user_url = url_for controller: 'comments', action: 'new', shop: @user.hash_for_url

      @limpieza = @comments.select {|comment| comment.category == "Limpieza"}
      @atencionalcliente = @comments.select {|comment| comment.category == "Atención al cliente"}
      @ubicacion = @comments.select {|comment| comment.category == "Ubicación"}
      @seguridad = @comments.select {|comment| comment.category == "Seguridad"}
      @otras = @comments.select {|comment| comment.category == "Otras"}

      @all_categories = [@limpieza.count, @atencionalcliente.count, @ubicacion.count, @seguridad.count, @otras.count]

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

      @data_one = [@comments.select{|comment| comment.rating == 1}.select {|comment| comment.category == "Limpieza"}.count,
                   @comments.select{|comment| comment.rating == 1}.select {|comment| comment.category == "Atención al cliente"}.count,
                   @comments.select{|comment| comment.rating == 1}.select {|comment| comment.category == "Ubicación"}.count,
                   @comments.select{|comment| comment.rating == 1}.select {|comment| comment.category == "Seguridad"}.count,
                   @comments.select{|comment| comment.rating == 1}.select {|comment| comment.category == "Otras"}.count]

      @data_two = [@comments.select{|comment| comment.rating == 2}.select {|comment| comment.category == "Limpieza"}.count,
                   @comments.select{|comment| comment.rating == 2}.select {|comment| comment.category == "Atención al cliente"}.count,
                   @comments.select{|comment| comment.rating == 2}.select {|comment| comment.category == "Ubicación"}.count,
                   @comments.select{|comment| comment.rating == 2}.select {|comment| comment.category == "Seguridad"}.count,
                   @comments.select{|comment| comment.rating == 2}.select {|comment| comment.category == "Otras"}.count]

      @data_three = [@comments.select{|comment| comment.rating == 3}.select {|comment| comment.category == "Limpieza"}.count,
                     @comments.select{|comment| comment.rating == 3}.select {|comment| comment.category == "Atención al cliente"}.count,
                     @comments.select{|comment| comment.rating == 3}.select {|comment| comment.category == "Ubicación"}.count,
                     @comments.select{|comment| comment.rating == 3}.select {|comment| comment.category == "Seguridad"}.count,
                     @comments.select{|comment| comment.rating == 3}.select {|comment| comment.category == "Otras"}.count]

      @data_four = [@comments.select{|comment| comment.rating == 4}.select {|comment| comment.category == "Limpieza"}.count,
                    @comments.select{|comment| comment.rating == 4}.select {|comment| comment.category == "Atención al cliente"}.count,
                    @comments.select{|comment| comment.rating == 4}.select {|comment| comment.category == "Ubicación"}.count,
                    @comments.select{|comment| comment.rating == 4}.select {|comment| comment.category == "Seguridad"}.count,
                    @comments.select{|comment| comment.rating == 4}.select {|comment| comment.category == "Otras"}.count]

      @data_five = [@comments.select{|comment| comment.rating == 5}.select {|comment| comment.category == "Limpieza"}.count,
                    @comments.select{|comment| comment.rating == 5}.select {|comment| comment.category == "Atención al cliente"}.count,
                    @comments.select{|comment| comment.rating == 5}.select {|comment| comment.category == "Ubicación"}.count,
                    @comments.select{|comment| comment.rating == 5}.select {|comment| comment.category == "Seguridad"}.count,
                    @comments.select{|comment| comment.rating == 5}.select {|comment| comment.category == "Otras"}.count]

      @data_selected
      @data_axis
      @bar_colors = ['FFFF00']
      @title = params[:category]
      @legend = ['Cantidad de comentarios']
      @axis_labels = ['1|2|3|4|5']

      case params[:category]
      when "Limpieza"
        @data_selected = @datalimpieza
        @data_axis = @data_selected
      when "Atención al cliente"
        @data_selected = @dataatencionalcliente
        @data_axis = @data_selected
      when "Ubicación"
        @data_selected = @dataubicacion
        @data_axis = @data_selected
      when "Seguridad"
        @data_selected = @dataseguridad
        @data_axis = @data_selected
      when "Otras"
        @data_selected = @dataotras
        @data_axis = @data_selected
      else
        @data_selected = [@data_one, @data_two, @data_three, @data_four, @data_five]
        @data_axis = @all_categories
        @bar_colors = ['FFFF00', '0000FF', '00FF00', 'FF0000', '000000']
        @title = "Comentarios agrupados por categoría"
        @legend = ['1 estrella', '2 estrellas', '3 estrellas', '4 estrellas', '5 estrellas']
        @axis_labels = ['Limpieza|Atención al cliente|Ubicación|Seguridad|Otras']
      end

      @bar_chart_selected = Gchart.bar(
          :type => 'bar',
          :size => '600x400',
          :bar_colors => @bar_colors,
          :title => @title,
          :bg => 'EFEFEF',
          :legend => @legend,
          :data => @data_selected,
          :axis_with_labels => [['x'], ['y']],
          :axis_range => [nil, [0, @data_axis.max]],
          :min_value => 0,
          :axis_labels => @axis_labels,
          :bar_width_and_spacing => '25,60',
          )

      end
  end
end
