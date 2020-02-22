# -*- coding: utf-8 -*-

    # posee_desc_parts_controller.rb
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


class PoseeDescPartsController < ApplicationController
  # GET /posee_desc_parts
  # GET /posee_desc_parts.xml
  def index
    if not verificar_privilegios(PoseeDescPart::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los datos de \"Posee Descriptores Particulares\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_desc_parts = PoseeDescPart.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @posee_desc_parts }
      end
    end
  end

  # GET /posee_desc_parts/1
  # GET /posee_desc_parts/1.xml
  def show
    if not verificar_privilegios(PoseeDescPart::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los datos de \"Posee Descriptores Particulares\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_desc_part = PoseeDescPart.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @posee_desc_part }
      end
    end
  end

  # GET /posee_desc_parts/new
  # GET /posee_desc_parts/new.xml
  def new
    if not verificar_privilegios(PoseeDescPart::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los datos de \"Posee Descriptores Particulares\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_desc_part = PoseeDescPart.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @posee_desc_part }
      end
    end
  end

  # GET /posee_desc_parts/1/edit
  def edit
    if not verificar_privilegios(PoseeDescPart::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los datos de \"Posee Descriptores Particulares\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_desc_part = PoseeDescPart.find(params[:id])
    end
  end

  # POST /posee_desc_parts
  # POST /posee_desc_parts.xml
  def create
    if not verificar_privilegios(PoseeDescPart::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los datos de \"Posee Descriptores Particulares\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_desc_part = PoseeDescPart.new(params[:posee_desc_part])

      respond_to do |format|
        if @posee_desc_part.save
          flash[:notice] = 'Se ha creado exitósamente.'
          format.html { redirect_to(@posee_desc_part) }
          format.xml  { render :xml => @posee_desc_part, :status => :created, :location => @posee_desc_part }
        else
          flash[:notice] = '¡Surgió un error al crear!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @posee_desc_part.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /posee_desc_parts/1
  # PUT /posee_desc_parts/1.xml
  def update
    if not verificar_privilegios(PoseeDescPart::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los datos de \"Posee Descriptores Particulares\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_desc_part = PoseeDescPart.find(params[:id])

      respond_to do |format|
        if @posee_desc_part.update_attributes(params[:posee_desc_part])
          flash[:notice] = 'Se ha actualizado exitósamente.'
          format.html { redirect_to(@posee_desc_part) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @posee_desc_part.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /posee_desc_parts/1
  # DELETE /posee_desc_parts/1.xml
  def destroy
    if not verificar_privilegios(PoseeDescPart::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar los datos de \"Posee Descriptores Particulares\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @posee_desc_part = PoseeDescPart.find(params[:id])
      @posee_desc_part.destroy

      respond_to do |format|
        format.html { redirect_to(posee_desc_parts_url) }
        format.xml  { head :ok }
      end
    end
  end
end
