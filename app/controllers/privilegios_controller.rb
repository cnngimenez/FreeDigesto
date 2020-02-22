    # privilegios_controller.rb
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


class PrivilegiosController < ApplicationController
  # GET /privilegios
  # GET /privilegios.xml
  def index    
    if not verificar_privilegios(Privilegio::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
        @privilegios = Privilegio.find(:all)

        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @privilegios }
        end
      end
    end
  
  # GET /privilegios/1
  # GET /privilegios/1.xml
  def show
    if not verificar_privilegios(Privilegio::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @privilegio = Privilegio.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @privilegio }
      end
    end
  end

  # GET /privilegios/new
  # GET /privilegios/new.xml
  def new
    if not verificar_privilegios(Privilegio::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @privilegio = Privilegio.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @privilegio }
      end
    end
  end

  # GET /privilegios/1/edit
  def edit
    if not verificar_privilegios(Privilegio::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @privilegio = Privilegio.find(params[:id])
    end
  end

  # POST /privilegios
  # POST /privilegios.xml
  def create
    if not verificar_privilegios(Privilegio::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @privilegio = Privilegio.new(params[:privilegio])

      respond_to do |format|
        if @privilegio.save
          flash[:notice] = 'El privilegio se ha creado exitósamente.'
          format.html { redirect_to(@privilegio) }
          format.xml  { render :xml => @privilegio, :status => :created, :location => @privilegio }
        else
          flash[:notice] = '¡Surgió un error al crear el privilegio!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @privilegio.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /privilegios/1
  # PUT /privilegios/1.xml
  def update
    if not verificar_privilegios(Privilegio::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @privilegio = Privilegio.find(params[:id])

      respond_to do |format|
        if @privilegio.update_attributes(params[:privilegio])
          flash[:notice] = 'Se ha actualizado el privilegio exitósamente.'
          format.html { redirect_to(@privilegio) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar el privilegio!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @privilegio.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /privilegios/1
  # DELETE /privilegios/1.xml
  def destroy
    if not verificar_privilegios(Privilegio::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar privilegios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @privilegio = Privilegio.find(params[:id])
      @privilegio.destroy

      respond_to do |format|
        format.html { redirect_to(privilegios_url) }
        format.xml  { head :ok }
      end
    end
  end
end