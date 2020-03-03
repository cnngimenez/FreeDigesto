# -*- coding: utf-8 -*-

# buscar_por_numero_controller.rb
# Copyright (C) 2010  Giménez, Christian N.

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

# Jueves 07 De Octubre Del 2010

class BuscarPorNumeroController < ApplicationController

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

  def buscar_numero
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else

      if params[:buscar_numero][:numero] == '' and
        params[:buscar_numero][:estado_todos] != '1' and
        params[:buscar_numero][:tipo_norma_todos] != '1' and
        params[:buscar_numero][:general_particular] == "Todos"

        flash[:notice] = '¡Escriba un numero y/o seleccione una opción!'

        respond_to do |format|
          format.html {render :action => 'index'}
        end
        return
      end

      numero = params[:buscar_numero][:numero]

      condiciones = Hash.new

      if params[:buscar_numero][:estado_todos] == '1'
        #Selecciono un estado.
        condiciones[:estado_id] = params[:buscar_numero][:estado_id]
      end

      if params[:buscar_numero][:tipo_norma_todos] == '1'
        #Seleccionó un tipo de norma en particular.
        condiciones[:tipo_norma_id]=params[:buscar_numero][:tipo_norma_id]
      end

      if params[:buscar_numero][:general_particular] == "Generales"
        #Eligió buscar los que sean generales
        condiciones[:general] = true
      end

      if params[:buscar_numero][:general_particular] == "Particulares"
        #Eligió buscar los que sean particulares
        condiciones[:general] = false
      end

      orden = armar_orden(params[:buscar_numero])

      @lstNormas = Norma.buscar_por_numero(numero, condiciones, orden)

      respond_to do |format|
        format.html {render :action => 'resultados'}
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

      if params[:buscar_numero][:numero] == '' and
        params[:buscar_numero][:estado_todos] != '1' and
        params[:buscar_numero][:tipo_norma_todos] != '1' and
        params[:buscar_numero][:general_particular] == "Todos"

        flash[:notice] = '¡Escriba un numero y/o seleccione una opción!'

        respond_to do |format|
          format.html {render :action => 'index'}
        end
        return
      end

      numero = params[:buscar_numero][:numero]

      condiciones = Hash.new

      if params[:buscar_numero][:estado_todos] == '1'
        #Selecciono un estado.
        condiciones[:estado_id] = params[:buscar_numero][:estado_id]
      end

      if params[:buscar_numero][:tipo_norma_todos] == '1'
        #Seleccionó un tipo de norma en particular.
        condiciones[:tipo_norma_id]=params[:buscar_numero][:tipo_norma_id]
      end

      if params[:buscar_numero][:general_particular] == "Generales"
        #Eligió buscar los que sean generales
        condiciones[:general] = true
      end

      if params[:buscar_numero][:general_particular] == "Particulares"
        #Eligió buscar los que sean particulares
        condiciones[:general] = false
      end

      orden = armar_orden(params[:buscar_numero])

      @lstNormas = Norma.buscar_por_numero(numero, condiciones, orden)

      respond_to do |format|
        format.html {render :layout => "resultados_amigable_impresion"}
      end
    end
  end

end
