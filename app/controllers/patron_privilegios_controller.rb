# coding: utf-8

    # patron_privilegios_controller.rb
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


class PatronPrivilegiosController < ApplicationController
  # GET /patron_privilegios
  # GET /patron_privilegios.xml
  def index
    if not verificar_privilegios(PatronPrivilegio::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los datos de los patrones de privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @patron_privilegios = PatronPrivilegio.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @patron_privilegios }
      end
    end
  end

  # GET /patron_privilegios/1
  # GET /patron_privilegios/1.xml
  def show
    if not verificar_privilegios(PatronPrivilegio::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los datos de los patrones de privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @patron_privilegio = PatronPrivilegio.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @patron_privilegio }
      end
    end
  end

  # GET /patron_privilegios/new
  # GET /patron_privilegios/new.xml
  def new
    if not verificar_privilegios(PatronPrivilegio::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear un patron de privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @patron_privilegio = PatronPrivilegio.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @patron_privilegio }
      end
    end
  end

  # GET /patron_privilegios/1/edit
  def edit
    if not verificar_privilegios(PatronPrivilegio::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los patrones de privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @patron_privilegio = PatronPrivilegio.find(params[:id])
    end
  end

  # POST /patron_privilegios
  # POST /patron_privilegios.xml
  def create
    if not verificar_privilegios(PatronPrivilegio::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los datos de los patrones de privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @patron_privilegio = PatronPrivilegio.new(params[:patron_privilegio])

      respond_to do |format|
        if @patron_privilegio.save
          flash[:notice] = 'PatronPrivilegio was successfully created.'
          format.html { redirect_to(@patron_privilegio) }
          format.xml  { render :xml => @patron_privilegio, :status => :created, :location => @patron_privilegio }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @patron_privilegio.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /patron_privilegios/1
  # PUT /patron_privilegios/1.xml
  def update
    if not verificar_privilegios(PatronPrivilegio::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los patrones de privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @patron_privilegio = PatronPrivilegio.find(params[:id])

      respond_to do |format|
        if @patron_privilegio.update_attributes(params[:patron_privilegio])
          flash[:notice] = 'PatronPrivilegio was successfully updated.'
          format.html { redirect_to(@patron_privilegio) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @patron_privilegio.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  # DELETE /patron_privilegios/1
  # DELETE /patron_privilegios/1.xml
  def destroy
    if not verificar_privilegios(PatronPrivilegio::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los datos de los patrones de privilegios\"!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @patron_privilegio = PatronPrivilegio.find(params[:id])
      @patron_privilegio.destroy

      respond_to do |format|
        format.html { redirect_to(patron_privilegios_url) }
        format.xml  { head :ok }
      end
    end
  end
end
