# -*- coding: utf-8 -*-

    # posee_descriptors_controller.rb
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


class PoseeDescriptorsController < ApplicationController
  # GET /posee_descriptors
  # GET /posee_descriptors.xml
  def index
    if not verificar_privilegios(PoseeDescriptor::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los datos de \"Posee Descriptores\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_descriptors = PoseeDescriptor.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @posee_descriptors }
      end
    end
  end

  # GET /posee_descriptors/1
  # GET /posee_descriptors/1.xml
  def show
    if not verificar_privilegios(PoseeDescriptor::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los datos de \"Posee Descriptores\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_descriptor = PoseeDescriptor.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @posee_descriptor }
      end
    end
  end

  # GET /posee_descriptors/new
  # GET /posee_descriptors/new.xml
  def new
    if not verificar_privilegios(PoseeDescriptor::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los datos de \"Posee Descriptores\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_descriptor = PoseeDescriptor.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @posee_descriptor }
      end
    end
  end

  # GET /posee_descriptors/1/edit
  def edit
    if not verificar_privilegios(PoseeDescriptor::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los datos de \"Posee Descriptores\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_descriptor = PoseeDescriptor.find(params[:id])
    end
  end

  # POST /posee_descriptors
  # POST /posee_descriptors.xml
  def create
    if not verificar_privilegios(PoseeDescriptor::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los datos de \"Posee Descriptores\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_descriptor = PoseeDescriptor.new(params[:posee_descriptor])

      respond_to do |format|
        if @posee_descriptor.save
          flash[:notice] = 'Se ha creado exitósamente.'
          format.html { redirect_to(@posee_descriptor) }
          format.xml  { render :xml => @posee_descriptor, :status => :created, :location => @posee_descriptor }
        else
          flash[:notice] = '¡Surgió un error al crear!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @posee_descriptor.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /posee_descriptors/1
  # PUT /posee_descriptors/1.xml
  def update
    if not verificar_privilegios(PoseeDescriptor::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los datos de \"Posee Descriptores\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_descriptor = PoseeDescriptor.find(params[:id])

      respond_to do |format|
        if @posee_descriptor.update_attributes(params[:posee_descriptor])
          flash[:notice] = 'Se ha actualizado correctamente.'
          format.html { redirect_to(@posee_descriptor) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @posee_descriptor.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /posee_descriptors/1
  # DELETE /posee_descriptors/1.xml
  def destroy
    if not verificar_privilegios(PoseeDescriptor::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar los datos de \"Posee Descriptores\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_descriptor = PoseeDescriptor.find(params[:id])
      @posee_descriptor.destroy

      respond_to do |format|
        format.html { redirect_to(posee_descriptors_url) }
        format.xml  { head :ok }
      end
    end
  end
end
