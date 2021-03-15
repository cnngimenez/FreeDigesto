# coding: utf-8

    # causa_cambio_estados_controller.rb
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


class CausaCambioEstadosController < ApplicationController
  # GET /causa_cambio_estados
  # GET /causa_cambio_estados.xml
  def index
   if not verificar_privilegios(CausaCambioEstado::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las causas de los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @causa_cambio_estados = CausaCambioEstado.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @causa_cambio_estados }
      end
   end
  end

  # GET /causa_cambio_estados/1
  # GET /causa_cambio_estados/1.xml
  def show
    if not verificar_privilegios(CausaCambioEstado::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las causas de los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @causa_cambio_estado = CausaCambioEstado.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @causa_cambio_estado }
      end
    end
  end

  # GET /causa_cambio_estados/new
  # GET /causa_cambio_estados/new.xml
  def new
    if not verificar_privilegios(CausaCambioEstado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear las causas de los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal' }
        format.xml { head :ok}
      end
    else
      @causa_cambio_estado = CausaCambioEstado.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @causa_cambio_estado }
      end
    end
  end

  # GET /causa_cambio_estados/1/edit
  def edit
    if not verificar_privilegios(CausaCambioEstado::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar las causas de los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @causa_cambio_estado = CausaCambioEstado.find(params[:id])
    end
  end

  # POST /causa_cambio_estados
  # POST /causa_cambio_estados.xml
  def create
    if not verificar_privilegios(CausaCambioEstado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear las causas de los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @causa_cambio_estado = CausaCambioEstado.new(params[:causa_cambio_estado])

      respond_to do |format|
        if @causa_cambio_estado.save
          flash[:notice] = 'La Causa de Cambio de Estado ha sido creada con éxito.'
          format.html { redirect_to(@causa_cambio_estado) }
          format.xml  { render :xml => @causa_cambio_estado, :status => :created, :location => @causa_cambio_estado }
        else
          flash[:notice] = '¡Surgió un error al crear una Causa de Cambio de Estado!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @causa_cambio_estado.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /causa_cambio_estados/1
  # PUT /causa_cambio_estados/1.xml
  def update
    if not verificar_privilegios(CausaCambioEstado::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar las causas de los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @causa_cambio_estado = CausaCambioEstado.find(params[:id])

      respond_to do |format|
        if @causa_cambio_estado.update_attributes(params[:causa_cambio_estado])
          flash[:notice] = 'La Causa de Cambio de Estado ha sido actualizado con éxito.'
          format.html { redirect_to(@causa_cambio_estado) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar la causa de cambio de estados!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @causa_cambio_estado.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /causa_cambio_estados/1
  # DELETE /causa_cambio_estados/1.xml
  def destroy
    if not verificar_privilegios(CausaCambioEstado::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar las causas de los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @causa_cambio_estado = CausaCambioEstado.find(params[:id])
      @causa_cambio_estado.destroy

      respond_to do |format|
        format.html { redirect_to(causa_cambio_estados_url) }
        format.xml  { head :ok }
      end
    end
  end
end
