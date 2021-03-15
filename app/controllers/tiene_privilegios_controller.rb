# coding: utf-8

    # tiene_privilegios_controller.rb
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


class TienePrivilegiosController < ApplicationController
  # GET /tiene_privilegios
  # GET /tiene_privilegios.xml
  def index
    if not verificar_privilegios(TienePrivilegio::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tiene_privilegios = TienePrivilegio.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @tiene_privilegios }
      end
    end
  end

  # GET /tiene_privilegios/1
  # GET /tiene_privilegios/1.xml
  def show
    if not verificar_privilegios(TienePrivilegio::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tiene_privilegio = TienePrivilegio.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @tiene_privilegio }
      end
    end
  end

  # GET /tiene_privilegios/new
  # GET /tiene_privilegios/new.xml
  def new
    if not verificar_privilegios(TienePrivilegio::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tiene_privilegio = TienePrivilegio.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @tiene_privilegio }
      end
    end
  end

  # GET /tiene_privilegios/1/edit
  def edit
    if not verificar_privilegios(TienePrivilegio::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tiene_privilegio = TienePrivilegio.find(params[:id])
    end
  end

  # POST /tiene_privilegios
  # POST /tiene_privilegios.xml
  def create
    if not verificar_privilegios(TienePrivilegio::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tiene_privilegio = TienePrivilegio.new(params[:tiene_privilegio])

      respond_to do |format|
        if @tiene_privilegio.save
          flash[:notice] = 'Se ha agregado el privilegio exitósamente.'
          format.html { redirect_to(@tiene_privilegio) }
          format.xml  { render :xml => @tiene_privilegio, :status => :created, :location => @tiene_privilegio }
        else
          flash[:notice] = '¡Surgió un error al agregar el privilegio!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @tiene_privilegio.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /tiene_privilegios/1
  # PUT /tiene_privilegios/1.xml
  def update
    if not verificar_privilegios(TienePrivilegio::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tiene_privilegio = TienePrivilegio.find(params[:id])

      respond_to do |format|
        if @tiene_privilegio.update_attributes(params[:tiene_privilegio])
          flash[:notice] = 'Se ha actualizado exitósamente.'
          format.html { redirect_to(@tiene_privilegio) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @tiene_privilegio.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /tiene_privilegios/1
  # DELETE /tiene_privilegios/1.xml
  def destroy
    if not verificar_privilegios(TienePrivilegio::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tiene_privilegio = TienePrivilegio.find(params[:id])
      @tiene_privilegio.destroy

      respond_to do |format|
        format.html { redirect_to(tiene_privilegios_url) }
        format.xml  { head :ok }
      end
    end
  end
end
