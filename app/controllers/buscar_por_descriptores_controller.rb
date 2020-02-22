# -*- coding: utf-8 -*-

    # buscar_por_descriptores_controller.rb
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


class BuscarPorDescriptoresController < ApplicationController
  def index
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @lstDescriptores = DescriptorGeneral.all(:order => "nombre ASC")
      respond_to do |format|
        format.html
      end
    end
  end

  def buscar_desc_part
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      id = params[:buscar_descriptor][:descriptor_general_id]

      respond_to do |format|
        format.html{redirect_to :action => "elegir_desc_part", :id => id}
      end
    end
  end

  def elegir_desc_part
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @descgen = DescriptorGeneral.find(params[:id])

      if (@descgen.nil?)
        @descgen = DescriptorGeneral.new
        @lstDescParts = []
        flash[:notice] = "¡No se encontró ese descriptor particular!"
      else
        @lstDescParts = DescriptorParticular.find_all_by_descriptor_general_id(@descgen.id, :order => "nombre ASC")
      end

      respond_to do |format|
        format.html
      end
    end
  end

  def otras_opciones
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      descpart_id = params[:descriptor_particular][:descriptor_particular_id]
      descgen_id = params[:descgen_id]

      unless descpart_id.nil? or descpart_id == ""
        @descpart = DescriptorParticular.find(descpart_id)
      else
        @descpart = nil
      end

      @descgen =  DescriptorGeneral.find(descgen_id)

      respond_to do |format|
        format.html
      end
    end
  end

  def buscar_normas
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else

      # No hay información en buscar_desc... viene del formulario anterior(otras_opciones)
      # reacomodar la variable params para que pueda ser aceptado por las condiciones que continúan
      # y además porque los formularios de esta view, generan esta misma estructura.
      if params[:buscar_desc].nil?
        params[:buscar_desc] = params
        params[:buscar_desc].update(params[:otras_opciones])
        params.delete(:otras_opciones)
      end

      descpart_id = params[:buscar_desc][:descpart_id]
      descgen_id = params[:buscar_desc][:descgen_id]

      otras_opciones = Hash.new

      if params[:buscar_desc][:estado_todos] == '1'
        #Selecciono un estado.
        otras_opciones[:estado_id] = params[:buscar_desc][:estado_id]
      end

      if params[:buscar_desc][:tipo_norma_todos] == '1'
        #Seleccionó un tipo de norma en particular.
        otras_opciones[:tipo_norma_id]=params[:buscar_desc][:tipo_norma_id]
      end

      if params[:buscar_desc][:general_particular] == "Generales"
        #Eligió buscar los que sean generales
        otras_opciones[:general] = true
      end

      if params[:buscar_desc][:general_particular] == "Particulares"
        #Eligió buscar los que sean particulares
        otras_opciones[:general] = false
      end


      #Buscar las normas que poseen tales descriptores.
      @lstNormas = Norma.buscar_por_descriptor(descgen_id, descpart_id, otras_opciones)

      orden = armar_orden(params[:buscar_desc])

      #Buscar las normas que poseen tales descriptores.
      @lstNormas = Norma.buscar_por_descriptor(descgen_id, descpart_id, otras_opciones, orden)

      respond_to do |format|
        format.html{render :action => "resultados"}
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
      # No hay información en buscar_desc... viene del formulario anterior(otras_opciones)
      # reacomodar la variable params para que pueda ser aceptado por las condiciones que continúan
      # y además porque los formularios de esta view, generan esta misma estructura.
      if params[:buscar_desc].nil?
        params[:buscar_desc] = params
        params[:buscar_desc].update(params[:otras_opciones])
        params.delete(:otras_opciones)
      end

      descpart_id = params[:buscar_desc][:descpart_id]
      descgen_id = params[:buscar_desc][:descgen_id]

      otras_opciones = Hash.new

      if params[:buscar_desc][:estado_todos] == '1'
        #Selecciono un estado.
        otras_opciones[:estado_id] = params[:buscar_desc][:estado_id]
      end

      if params[:buscar_desc][:tipo_norma_todos] == '1'
        #Seleccionó un tipo de norma en particular.
        otras_opciones[:tipo_norma_id]=params[:buscar_desc][:tipo_norma_id]
      end

      if params[:buscar_desc][:general_particular] == "Generales"
        #Eligió buscar los que sean generales
        otras_opciones[:general] = true
      end

      if params[:buscar_desc][:general_particular] == "Particulares"
        #Eligió buscar los que sean particulares
        otras_opciones[:general] = false
      end


      #Buscar las normas que poseen tales descriptores.
      @lstNormas = Norma.buscar_por_descriptor(descgen_id, descpart_id, otras_opciones)

      orden = armar_orden(params[:buscar_desc])

      #Buscar las normas que poseen tales descriptores.
      @lstNormas = Norma.buscar_por_descriptor(descgen_id, descpart_id, otras_opciones, orden)


      respond_to do |format|
        format.html{render :layout => "resultados_amigable_impresion"}
      end
    end
  end
end
