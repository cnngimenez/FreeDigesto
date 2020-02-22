# -*- coding: utf-8 -*-

    # agregar_privilegios_controller.rb
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


class AgregarPrivilegiosController < ApplicationController
  # GET /agregar_privilegios
  # GET /agregar_privilegios.xml
  def index
    if not verificar_privilegios(AgregarPrivilegio::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los datos de \"Agregar Privilegios\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @agregar_privilegios = AgregarPrivilegio.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @agregar_privilegios }
      end
    end
  end

  # GET /agregar_privilegios/1
  # GET /agregar_privilegios/1.xml
  def show
    if not verificar_privilegios(AgregarPrivilegio::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los datos de \"Agregar Privilegios\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @agregar_privilegio = AgregarPrivilegio.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @agregar_privilegio }
      end
    end
  end

  # GET /agregar_privilegios/new
  # GET /agregar_privilegios/new.xml
  def new
    if not verificar_privilegios(AgregarPrivilegio::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear datos de \"Agregar Privilegios\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @agregar_privilegio = AgregarPrivilegio.new

      id = params[:patron]
      if (id.nil? or id == '')
        @patron_privilegio = nil
      else
        @patron_privilegio = PatronPrivilegio.find(id)
      end

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @agregar_privilegio }
      end
    end
  end

  # GET /agregar_privilegios/1/edit
  def edit
    # NO DEBE ACCEDER A ESTA PÁGINA.
    # ¿Cuál sería el propósito de editar esta relación?
    # ¡Redireccionar al index!
    redirect_to :action => 'index'

    if not verificar_privilegios(AgregarPrivilegio::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los datos de \"Agregar Privilegios\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @agregar_privilegio = AgregarPrivilegio.find(params[:id])
    end
  end

  # POST /agregar_privilegios
  # POST /agregar_privilegios.xml
  def create
    if not verificar_privilegios(AgregarPrivilegio::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los datos de \"Agregar Privilegios\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @agregar_privilegio = AgregarPrivilegio.new(params[:agregar_privilegio])

      patron_id = params[:patron]
      unless (patron_id.nil?)
        @agregar_privilegio.patron_privilegio = PatronPrivilegio.find(patron_id)
      end

      respond_to do |format|
        if @agregar_privilegio.save
          flash[:notice] = 'Agregar Privilegio ha sido creado con éxito.'
          format.html { redirect_to(@agregar_privilegio) }
          format.xml  { render :xml => @agregar_privilegio, :status => :created, :location => @agregar_privilegio }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @agregar_privilegio.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /agregar_privilegios/1
  # PUT /agregar_privilegios/1.xml
  def update
    if not verificar_privilegios(AgregarPrivilegio::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los datos de \"Agregar Privilegios\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @agregar_privilegio = AgregarPrivilegio.find(params[:id])

      respond_to do |format|
        if @agregar_privilegio.update_attributes(params[:agregar_privilegio])
          flash[:notice] = 'Agregar Privilegio ha sido creado con éxito.'
          format.html { redirect_to(@agregar_privilegio) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @agregar_privilegio.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /agregar_privilegios/1
  # DELETE /agregar_privilegios/1.xml
  def destroy
    if not verificar_privilegios(AgregarPrivilegio::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar datos de \"Agregar Privilegios\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @agregar_privilegio = AgregarPrivilegio.find(params[:id])
      @agregar_privilegio.destroy

      respond_to do |format|
        format.html { redirect_to(agregar_privilegios_url) }
        format.xml  { head :ok }
      end
    end
  end
end
