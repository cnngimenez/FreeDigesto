# -*- coding: utf-8 -*-

    # agregar_descriptores_controller.rb
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


class AgregarDescriptoresController < ApplicationController

  # Index acepta como parámetro en GET o POST:
  # +creando_norma+: Indica si se llamó desde el asistente (controller) "nueva_norma".

  def index
    if not verificar_privilegios(PoseeDescriptor::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar descriptores generales!"
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

  # Acepta como parámetro en GET o POST:
  # +creando_norma+: Indica si se llamó desde el asistente (controller) "nueva_norma".
  # +id+: _id_ de la norma que se eligió para agregar el descriptor.
  # +norma+,+numero+: Número de la norma que se eligió(Usado por el formulario en index).
  def seleccionar_desc_gen
    if not verificar_privilegios(PoseeDescriptor::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      if not params[:id].nil?
        #buscar por id, pues hay un parámetro "id" pasado por GET o POST
        @norma = Norma.find(params[:id])
      elsif (not params[:norma].nil?) and (not params[:norma][:numero].nil?)
        #no hay id, o sea, buscar por número de norma pasado por POST por el index.html.erb
        #Véase app/view/agregar_descriptores/index.html.erb
        #flash[:notice] = params
        #raise
        @norma = Norma.buscar_por_num_ids(params[:norma][:numero],params[:norma][:tipo])
      end

      if (not @norma.nil?)
        #Buscar descriptores.
        @descriptores = DescriptorGeneral.find(:all, :order => "nombre ASC")

        @descElegidos = []

        #Obtener los ids de los descriptores que posee la norma @norma
        @descs= PoseeDescriptor.find_all_by_norma_id(@norma.id)
        if (not @descs.nil?)
          #Buscar todos los descriptores(los objetos) a partir del id.
          @descs.each do |d|
            @descElegidos.push DescriptorGeneral.find(d.descriptor_general_id)
          end
        end


        respond_to do |format|
          format.html
          #format.xml
        end
      else
        #No existe tal norma!
        #responder con error
        flash[:notice] = '¡No existe esa norma!'
        #TODO: ¡mostrar mensaje para que vuelva!
        respond_to do |format|
          format.html {redirect_to :back}
        end
      end

      
    end
  end

  # NOTA IMPORTANTE: En el desarrollo me ví obligado a hacer que cambie el uso
  # de ambas tablas: posee_descriptor y posee_desc_part
  #
  # Si el usuario agrega un descriptor particular A que pertenece al descriptor general B
  # se agrega A a la tabla posee_desc_part y B a la tabla posee_descriptor indicando que
  # la norma tiene tanto el descriptor particular A como el descriptor general B.
  #
  # ¡NO SE PUEDE AGREGAR EL DESCRIPTOR PARTICULAR A SÓLO SIN AGREGAR EL B EN LA TABLA
  # posee_descriptor!
  # 
  #

  # Acepta como parámetro en GET o POST:
  # +creando_norma+: Indica si se llamó desde el asistente (controller) "nueva_norma".
  # +id+: _id_ de la norma que se eligió para agregar el descriptor.
  # +descriptor+,+id+: El _id_ del descriptor general a agregar
  def agregar_desc_gen
    if not verificar_privilegios(PoseeDescriptor::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      lst_descs = params[:descriptor][:id].scan(/\d+ /)
      error = ""
      lst_descs.each{|desc_gen_id|
        #Crear la relación descriptor-norma
        @pd = PoseeDescriptor.new()
        @pd.norma_id = params[:id]
        @pd.descriptor_general_id = desc_gen_id.to_i
        #Grabarla
        unless @pd.save
          error = error + DescriptorGeneral.find(desc_gen_id).nombre + " "
        end
      }
      if not error == ""
        flash[:notice] = "Hubo un error al agregar los siguientes descriptores: \n" + error
      else
        flash[:notice] = "Todos los descriptores fueron agregados correctamente."
      end

      respond_to do |format|
       format.html {redirect_to :action => "seleccionar_desc_part", :id => params[:id],
         :ids_descriptores => params[:descriptor][:id]}
       format.xml {head :ok}
      end
    end
  end


  # Acepta como parámetro en GET o POST:
  # +creando_norma+: Indica si se llamó desde el asistente (controller) "nueva_norma".
  # +id+: _id_ de la norma que se eligió para agregar el descriptor.
  # +descriptorGen_id+: El _id_ del descriptor general para buscar los descriptores particulares
  #     que le corresponden.
  def seleccionar_desc_part
    #TODO: Verificar privilegios también por "posee_descriptors"
    if not verificar_privilegios(PoseeDescriptor::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar descriptores particulares!"
      respond_to do |format|
        format.html { redirect_to :action => 'otro'}
        format.xml { head :ok}
      end
    else      
      #Dejar disponible la norma para usarla en el view(cuarto.html.erb)
      @norma = Norma.find(params[:id])
      #Lo mismo para los descriptores particulares
      #Buscar por cada descriptor general sus particulares
      @lstDescParts = Array.new()
      lst_descs = params[:ids_descriptores].scan(/\d+ /)
      lst_descs.each{|desc_gen_id|
        #Buscar el descriptor general
        desc_gen = DescriptorGeneral.find(desc_gen_id)
        #Buscar sus particulares
        lst_desc_parts = DescriptorParticular.find_all_by_descriptor_general_id(desc_gen_id, :order=> "nombre ASC")
        #Guardarlo en el arreglo
        @lstDescParts.push([desc_gen, lst_desc_parts])
      }
      #Dejar disponible los descriptores particulares elegidos...
      @descElegidos = []
      @lstDescPartIds = PoseeDescPart.find_all_by_norma_id(@norma.id)
      if (not @lstDescPartIds.nil?)
        @lstDescPartIds.each do |d|
          @descElegidos.push DescriptorParticular.find(d.descriptor_particular_id)
        end
      end

      respond_to do |format|
        format.html
        format.xml
      end
    end
  end

  # Acepta como parámetro en GET o POST:
  # +creando_norma+: Indica si se llamó desde el asistente (controller) "nueva_norma".
  # +id+: _id_ de la norma que se eligió para agregar el descriptor.
  # +descriptor_particular+,+id+: El _id_ del descriptor particular a agregar.
  def agregar_desc_part
    if not verificar_privilegios(PoseeDescriptor::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar descriptores particulares!"
      respond_to do |format|
        format.html { redirect_to :action => 'otro'}
        format.xml { head :ok}
      end
    else
      if (not params[:descriptor_particular][:id].nil?) and
          (not params[:descriptor_particular][:id].empty?)

        lst_desc_parts = params[:descriptor_particular][:id].scan(/\d+ /)
        error = ""
        lst_desc_parts.each do |desc_part_id|
          #El usuario eligió un descriptor particular
          @dp = PoseeDescPart.new()
          @dp.descriptor_particular_id = desc_part_id.to_i
          @dp.norma_id = params[:id]

          unless @dp.save
            error = error + DescriptorParticular.find(desc_part_id).nombre + " "
          end
        end

        if error == ""
          flash[:notice] = '¡Se ha grabado satisfactoriamente!'
        else
          flash[:notice] = "Hubo problemas para agregar los siguientes descriptore particulares: "
          flash[:notice] = flash[:notice] + error
        end

        respond_to do |format|
          format.html {redirect_to :action => "otro", :id => params[:id]}
          format.xml
        end
      else
        #El usuario no eligió un descriptor particular.
        respond_to do |format|
          format.html {redirect_to :action => "otro", :id => params[:id]}
          format.xml
        end
      end      
    end
  end
  # Acepta como parámetro en GET o POST:
  # +creando_norma+: Indica si se llamó desde el asistente (controller) "nueva_norma".
  # +id+: _id_ de la norma que se eligió para agregar el descriptor.
  def otro
    if not verificar_privilegios(PoseeDescriptor::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar descriptores!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    end
  end
end
