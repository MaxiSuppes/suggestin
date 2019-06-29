class ReportsController < ApplicationController

  # GET /reports
  def index
    @user = current_user
    @comments = current_user.comments
    @user_url = url_for controller: 'comments', action: 'new', shop: @user.hash_for_url

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

      #@bar_chart_all = Gchart.bar(
       #   :type => 'bar',
        #  :size => '600x400',
      # :bar_colors => ['FFFF00', '0000FF', '00FF00', 'FF0000', '000000'],
      #    :title => "Comentarios agrupados por categoría",
       #   :bg => 'EFEFEF',
        #  :legend => ['1 estrella', '2 estrellas', '3 estrellas', '4 estrellas', '5 estrellas'],
         # :data => [@data_one, @data_two, @data_three, @data_four, @data_five],
          #:axis_with_labels => [['x'], ['y']],
        #  :axis_range => [nil, [0, @all_categories.max]],
         # :min_value => 0,
       #   :bar_width_and_spacing => '25,60',
        #  :axis_labels => ['Limpieza|Atención al cliente|Ubicación|Seguridad|Otras'],
         # )
    end

      @data_selected

      case params[:category]
      when "Limpieza"
        @data_selected = @datalimpieza
      when "Atención al cliente"
        @data_selected = @dataatencionalcliente
      when "Ubicación"
        @data_selected = @dataubicacion
      when "Seguridad"
        @data_selected = @dataseguridad
      when "Otras"
        @data_selected = @dataotras
      else
        @data_selected = @dataotras #TODO: esto es provisorio para testear
      end
      @bar_chart_selected = Gchart.bar(
          :type => 'bar',
          :size => '600x400',
          :bar_colors => ['FFFF00'],
          :title => params[:category],
          :bg => 'EFEFEF',
          :legend => ['Cantidad de comentarios'],
          :data => [@data_selected],
          :axis_with_labels => [['x'], ['y']],
          :axis_range => [nil, [0, @data_selected.max]],
          :min_value => 0,
          :axis_labels => ['1|2|3|4|5'],
          :stacked => false,
          )
    end
  end

end
