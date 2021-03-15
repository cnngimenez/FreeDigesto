# coding: utf-8

    # tipo_relacions_controller.rb
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


class TipoRelacionsController < ApplicationController
  # GET /tipo_relacions
  # GET /tipo_relacions.xml
  def index
    if not verificar_privilegios(TipoRelacion::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los tipos de relación!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @tipo_relacions = TipoRelacion.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @tipo_relacions }
      end
    end
  end

  # GET /tipo_relacions/1
  # GET /tipo_relacions/1.xml
  def show
    if not verificar_privilegios(TipoRelacion::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los tipos de relación!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @tipo_relacion = TipoRelacion.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @tipo_relacion }
      end
    end
  end

  # GET /tipo_relacions/new
  # GET /tipo_relacions/new.xml
  def new
    if not verificar_privilegios(TipoRelacion::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear tipos de relación!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @tipo_relacion = TipoRelacion.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @tipo_relacion }
      end
    end
  end

  # GET /tipo_relacions/1/edit
  def edit
    if not verificar_privilegios(TipoRelacion::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los tipos de relación!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @tipo_relacion = TipoRelacion.find(params[:id])
    end
  end

  # POST /tipo_relacions
  # POST /tipo_relacions.xml
  def create
    if not verificar_privilegios(TipoRelacion::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear tipos de relación!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @tipo_relacion = TipoRelacion.new(params[:tipo_relacion])

      respond_to do |format|
        if @tipo_relacion.save
          flash[:notice] = 'Se ha creado el tipo de relación exitósamente.'
          format.html { redirect_to(@tipo_relacion) }
          format.xml  { render :xml => @tipo_relacion, :status => :created, :location => @tipo_relacion }
        else
          flash[:notice] = '¡Surgió un error al crear el tipo de relación!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @tipo_relacion.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /tipo_relacions/1
  # PUT /tipo_relacions/1.xml
  def update
    if not verificar_privilegios(TipoRelacion::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los tipos de relación!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @tipo_relacion = TipoRelacion.find(params[:id])

      respond_to do |format|
        if @tipo_relacion.update_attributes(params[:tipo_relacion])
          flash[:notice] = 'Se ha actualizado el tipo de relación exitósamente.'
          format.html { redirect_to(@tipo_relacion) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar el tipo de relación!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @tipo_relacion.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /tipo_relacions/1
  # DELETE /tipo_relacions/1.xml
  def destroy
    if not verificar_privilegios(TipoRelacion::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar los tipos de relación!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @tipo_relacion = TipoRelacion.find(params[:id])
      @tipo_relacion.destroy

      respond_to do |format|
        format.html { redirect_to(tipo_relacions_url) }
        format.xml  { head :ok }
      end
    end
  end
end
