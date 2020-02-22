# -*- coding: utf-8 -*-

    # descriptor_generals_controller.rb
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


class DescriptorGeneralsController < ApplicationController
  # GET /descriptor_generals
  # GET /descriptor_generals.xml
  def index
    if not verificar_privilegios(DescriptorGeneral::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_generals = DescriptorGeneral.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @descriptor_generals }
      end
    end
  end

  # GET /descriptor_generals/1
  # GET /descriptor_generals/1.xml
  def show
    if not verificar_privilegios(DescriptorGeneral::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_general = DescriptorGeneral.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @descriptor_general }
      end
    end
  end

  # GET /descriptor_generals/new
  # GET /descriptor_generals/new.xml
  def new
    if not verificar_privilegios(DescriptorGeneral::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_general = DescriptorGeneral.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @descriptor_general }
      end
    end
  end

  # GET /descriptor_generals/1/edit
  def edit
    if not verificar_privilegios(DescriptorGeneral::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_general = DescriptorGeneral.find(params[:id])
    end
  end

  # POST /descriptor_generals
  # POST /descriptor_generals.xml
  def create
    if not verificar_privilegios(DescriptorGeneral::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_general = DescriptorGeneral.new(params[:descriptor_general])

      respond_to do |format|
        if @descriptor_general.save
          flash[:notice] = 'El descriptor general fue creado exitosamente.'
          format.html { redirect_to(@descriptor_general) }
          format.xml  { render :xml => @descriptor_general, :status => :created, :location => @descriptor_general }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @descriptor_general.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /descriptor_generals/1
  # PUT /descriptor_generals/1.xml
  def update
    if not verificar_privilegios(DescriptorGeneral::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_general = DescriptorGeneral.find(params[:id])

      respond_to do |format|
        if @descriptor_general.update_attributes(params[:descriptor_general])
          flash[:notice] = 'El descriptor general fue actualizado exitosamente.'
          format.html { redirect_to(@descriptor_general) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @descriptor_general.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /descriptor_generals/1
  # DELETE /descriptor_generals/1.xml
  def destroy
    if not verificar_privilegios(DescriptorGeneral::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @descriptor_general = DescriptorGeneral.find(params[:id])
      @descriptor_general.destroy

      respond_to do |format|
        format.html { redirect_to(descriptor_generals_url) }
        format.xml  { head :ok }
      end
    end
  end
end
