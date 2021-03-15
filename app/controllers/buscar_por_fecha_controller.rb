# coding: utf-8

    # buscar_por_fecha_controller.rb
    # Copyright (C) 2011  Giménez, Christian N.

    # This program is free software: you can redistribute it and/or modify
    # it under the terms of the GNU General Public License as published by
    # the Free Software Foundation, either version 3 of the License, or
    # (at your option) any later version.

    # This program is distributed in the hope that it will be useful,
    # but WITHOUT ANY WARRANTY; without even the implied warranty of
    # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    # GNU General Public License for more details.

    # You should have received a copy of the GNU General Public License
    # along with this program.  If not, see <http://www.gnu.org/licenses/>.

    # Martes 19 De Abril Del 2011


class BuscarPorFechaController < ApplicationController

  def index
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def resultados
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else

      fecha_desde = [params[:buscar_fecha]['fecha_desde(1i)'],
                     params[:buscar_fecha]['fecha_desde(2i)'],
                     params[:buscar_fecha]['fecha_desde(3i)']]

      fecha_hasta = [params[:buscar_fecha]['fecha_hasta(1i)'],
                     params[:buscar_fecha]['fecha_hasta(2i)'],
                     params[:buscar_fecha]['fecha_hasta(3i)']
                    ]

      # Dependiendo de la selección (buscar por fecha de: sanción, publicación ó promulgación)
      # se arma la condición.
      #
      if (params[:buscar_fecha][:buscar_por] == 'sancion')
        # fecha_sanción >= fecha_desde AND fecha_sancion <= fecha_hasta
        tipo_fecha = Norma::Tipo_fecha_sancion
        str_fecha_desde = fecha_desde[0] + "-" + fecha_desde[1] + "-" + fecha_desde[2]
        str_fecha_hasta = fecha_hasta[0] + "-" + fecha_hasta[1] + "-" + fecha_hasta[2]
      elsif (params[:buscar_fecha][:buscar_por] == 'promulgacion')
        # fecha_promulgación >= fecha_desde AND fecha_promulgación <= fecha_hasta
        tipo_fecha = Norma::Tipo_fecha_promulgacion
        str_fecha_desde = fecha_desde[0] + "-" + fecha_desde[1] + "-" + fecha_desde[2]
        str_fecha_hasta = fecha_hasta[0] + "-" + fecha_hasta[1] + "-" + fecha_hasta[2]
      elsif (params[:buscar_fecha][:buscar_por] == 'publicacion')
        # fecha_publicación >= fecha_desde AND fecha_publicación <= fecha_hasta
        tipo_fecha = Norma::Tipo_fecha_publicacion
        str_fecha_desde = fecha_desde[0] + "-" + fecha_desde[1] + "-" + fecha_desde[2]
        str_fecha_hasta = fecha_hasta[0] + "-" + fecha_hasta[1] + "-" + fecha_hasta[2]
      end


      condiciones = Hash.new
      # Si eligió buscar por estado, entonces incorporar la condición:
      # "AND estado_id = [el estado que eligió]"
      if params[:buscar_fecha][:estado_todos] == '1'
        #Selecciono un estado.
        condiciones[:estado_id] = params[:buscar_fecha][:estado_id]
      end

      # Si eligió buscar por tipo de norma entonces agregar la condición
      # "AND tipo_norma_id = [el id del tipo de norma]"
      if params[:buscar_fecha][:tipo_norma_todos] == '1'
        #Seleccionó un tipo de norma en particular.
        condiciones[:tipo_norma_id] = params[:buscar_fecha][:tipo_norma_id]
      end

      # Si eligió buscar por general agregar la condición "general = true"
      if params[:buscar_fecha][:general_particular] == "Generales"
        #Eligió buscar los que sean generales
        condiciones[:general] = true
      end

      # Si eligió buscar por particular agregar la condición "general = false"
      if params[:buscar_fecha][:general_particular] == "Particulares"
        #Eligió buscar los que sean particulares
        condiciones[:general] = false
      end
      #Si eligió buscar por todas, general y/o particular entonces no agregar ninguna condición.

      orden = armar_orden(params[:buscar_fecha])

      @lstNormas = Norma.buscar_por_fecha(
        str_fecha_desde,
        str_fecha_hasta,
        tipo_fecha,
        condiciones,
        orden)

      respond_to do |format|
        format.html
      end
    end
  end

  def vista_impresion
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else


      fecha_desde = [params[:buscar_fecha]['fecha_desde(1i)'],
                     params[:buscar_fecha]['fecha_desde(2i)'],
                     params[:buscar_fecha]['fecha_desde(3i)']
                    ]

      fecha_hasta = [params[:buscar_fecha]['fecha_hasta(1i)'],
                     params[:buscar_fecha]['fecha_hasta(2i)'],
                     params[:buscar_fecha]['fecha_hasta(3i)']
      ]

      # Dependiendo de la selección (buscar por fecha de: sanción, publicación ó promulgación)
      # se arma la condición.
      #
      if (params[:buscar_fecha][:buscar_por] == 'sancion')
        # fecha_sanción >= fecha_desde AND fecha_sancion <= fecha_hasta
        tipo_fecha = Norma::Tipo_fecha_sancion
        str_fecha_desde = fecha_desde[0] + "-" + fecha_desde[1] + "-" + fecha_desde[2]
        str_fecha_hasta = fecha_hasta[0] + "-" + fecha_hasta[1] + "-" + fecha_hasta[2]
      elsif (params[:buscar_fecha][:buscar_por] == 'promulgacion')
        # fecha_promulgación >= fecha_desde AND fecha_promulgación <= fecha_hasta
        tipo_fecha = Norma::Tipo_fecha_promulgacion
        str_fecha_desde = fecha_desde[0] + "-" + fecha_desde[1] + "-" + fecha_desde[2]
        str_fecha_hasta = fecha_hasta[0] + "-" + fecha_hasta[1] + "-" + fecha_hasta[2]
      elsif (params[:buscar_fecha][:buscar_por] == 'publicacion')
        # fecha_publicación >= fecha_desde AND fecha_publicación <= fecha_hasta
        tipo_fecha = Norma::Tipo_fecha_publicacion
        str_fecha_desde = fecha_desde[0] + "-" + fecha_desde[1] + "-" + fecha_desde[2]
        str_fecha_hasta = fecha_hasta[0] + "-" + fecha_hasta[1] + "-" + fecha_hasta[2]
      end


      condiciones = Hash.new
      # Si eligió buscar por estado, entonces incorporar la condición:
      # "AND estado_id = [el estado que eligió]"
      if params[:buscar_fecha][:estado_todos] == '1'
        #Selecciono un estado.
        condiciones[:estado_id] = params[:buscar_fecha][:estado_id]
      end

      # Si eligió buscar por tipo de norma entonces agregar la condición
      # "AND tipo_norma_id = [el id del tipo de norma]"
      if params[:buscar_fecha][:tipo_norma_todos] == '1'
        #Seleccionó un tipo de norma en particular.
        condiciones[:tipo_norma_id] = params[:buscar_fecha][:tipo_norma_id]
      end

      # Si eligió buscar por general agregar la condición "general = true"
      if params[:buscar_fecha][:general_particular] == "Generales"
        #Eligió buscar los que sean generales
        condiciones[:general] = true
      end

      # Si eligió buscar por particular agregar la condición "general = false"
      if params[:buscar_fecha][:general_particular] == "Particulares"
        #Eligió buscar los que sean particulares
        condiciones[:general] = false
      end

      #Si eligió buscar por todas, general y/o particular entonces no agregar ninguna condición.

      orden = armar_orden(params[:buscar_fecha])

      @lstNormas = Norma.buscar_por_fecha(
                                          str_fecha_desde,
                                          str_fecha_hasta,
                                          tipo_fecha,
                                          condiciones,
                                          orden)

      respond_to do |format|
        format.html {render :layout => "resultados_amigable_impresion"}
      end
    end
  end
end
