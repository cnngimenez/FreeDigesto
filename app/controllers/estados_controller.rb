# -*- coding: utf-8 -*-

    # estados_controller.rb
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


class EstadosController < ApplicationController
  # GET /estados
  # GET /estados.xml
  def index
    if not verificar_privilegios(Estado::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @estados = Estado.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @estados }
      end
    end
  end

  # GET /estados/1
  # GET /estados/1.xml
  def show
    if not verificar_privilegios(Estado::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @estado = Estado.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @estado }
      end
    end
  end

  # GET /estados/new
  # GET /estados/new.xml
  def new
    if not verificar_privilegios(Estado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @estado = Estado.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @estado }
      end
    end
  end

  # GET /estados/1/edit
  def edit
    if not verificar_privilegios(Estado::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @estado = Estado.find(params[:id])
    end
  end

  # POST /estados
  # POST /estados.xml
  def create
    if not verificar_privilegios(Estado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @estado = Estado.new(params[:estado])

      respond_to do |format|
        if @estado.save
          flash[:notice] = 'El Estado ha sido creado con éxito.'
          format.html { redirect_to(@estado) }
          format.xml  { render :xml => @estado, :status => :created, :location => @estado }
        else
          flash[:notice] = '¡Surgió un error al crear el Estado!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @estado.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /estados/1
  # PUT /estados/1.xml
  def update
    if not verificar_privilegios(Estado::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @estado = Estado.find(params[:id])

      respond_to do |format|
        if @estado.update_attributes(params[:estado])
          flash[:notice] = 'El Estado ha sido actualizado con éxito.'
          format.html { redirect_to(@estado) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar el Estado!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @estado.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /estados/1
  # DELETE /estados/1.xml
  def destroy
    if not verificar_privilegios(Estado::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @estado = Estado.find(params[:id])
      @estado.destroy

      respond_to do |format|
        format.html { redirect_to(estados_url) }
        format.xml  { head :ok }
      end
    end
  end
end
