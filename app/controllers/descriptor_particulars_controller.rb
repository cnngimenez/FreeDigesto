# coding: utf-8

    # descriptor_particulars_controller.rb
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


class DescriptorParticularsController < ApplicationController
  # GET /descriptor_particulars
  # GET /descriptor_particulars.xml
  def index
    if not verificar_privilegios(DescriptorParticular::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar descriptores particulares!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_particulars = DescriptorParticular.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @descriptor_particulars }
      end
    end
  end

  # GET /descriptor_particulars/1
  # GET /descriptor_particulars/1.xml
  def show
    if not verificar_privilegios(DescriptorParticular::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar descriptores particulares!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_particular = DescriptorParticular.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @descriptor_particular }
      end
    end
  end

  # GET /descriptor_particulars/new
  # GET /descriptor_particulars/new.xml
  def new
    if not verificar_privilegios(DescriptorParticular::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear descriptores particulares!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_particular = DescriptorParticular.new

      #dejar disponibles todos los descriptores generales
      @descriptores = DescriptorGeneral.all

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @descriptor_particular }
      end
    end
  end

  # GET /descriptor_particulars/1/edit
  def edit
    if not verificar_privilegios(DescriptorParticular::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar descriptores particulares!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_particular = DescriptorParticular.find(params[:id])
      
      @descriptores = DescriptorGeneral.all
    end
  end

  # POST /descriptor_particulars
  # POST /descriptor_particulars.xml
  def create
    if not verificar_privilegios(DescriptorParticular::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear descriptores particulares!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_particular = DescriptorParticular.new(params[:descriptor_particular])

      respond_to do |format|
        if @descriptor_particular.save
          flash[:notice] = 'El Descriptor Particular ha sido creado con éxito.'
          format.html { redirect_to(@descriptor_particular) }
          format.xml  { render :xml => @descriptor_particular, :status => :created, :location => @descriptor_particular }
        else
          flash[:notice] = '¡Surgió un error al crear el descriptor particular!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @descriptor_particular.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /descriptor_particulars/1
  # PUT /descriptor_particulars/1.xml
  def update
    if not verificar_privilegios(DescriptorParticular::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar descriptores particulares!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_particular = DescriptorParticular.find(params[:id])

      respond_to do |format|
        if @descriptor_particular.update_attributes(params[:descriptor_particular])
          flash[:notice] = 'El descriptor particular ha sido actualizado con éxito.'
          format.html { redirect_to(@descriptor_particular) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Ha surgido un error al actualizar el descriptor particular!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @descriptor_particular.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /descriptor_particulars/1
  # DELETE /descriptor_particulars/1.xml
  def destroy
    if not verificar_privilegios(DescriptorParticular::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar descriptores particulares!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_particular = DescriptorParticular.find(params[:id])
      @descriptor_particular.destroy

      respond_to do |format|
        format.html { redirect_to(descriptor_particulars_url) }
        format.xml  { head :ok }
      end
    end
  end
end
