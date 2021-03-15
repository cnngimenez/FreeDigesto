# coding: utf-8

    # lugar_publicacions_controller.rb
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


class LugarPublicacionsController < ApplicationController
  # GET /lugar_publicacions
  # GET /lugar_publicacions.xml
  def index
    if not verificar_privilegios(LugarPublicacion::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los lugares de publicaciones!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @lugar_publicacions = LugarPublicacion.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @lugar_publicacions }
      end
    end
  end

  # GET /lugar_publicacions/1
  # GET /lugar_publicacions/1.xml
  def show
    if not verificar_privilegios(LugarPublicacion::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los lugares de publicaciones!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @lugar_publicacion = LugarPublicacion.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @lugar_publicacion }
      end
    end
  end

  # GET /lugar_publicacions/new
  # GET /lugar_publicacions/new.xml
  def new
    if not verificar_privilegios(LugarPublicacion::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear un lugar de publicacion!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @lugar_publicacion = LugarPublicacion.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @lugar_publicacion }
      end
    end
  end

  # GET /lugar_publicacions/1/edit
  def edit
    if not verificar_privilegios(LugarPublicacion::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los lugares de publicaciones!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @lugar_publicacion = LugarPublicacion.find(params[:id])
    end
  end

  # POST /lugar_publicacions
  # POST /lugar_publicacions.xml
  def create
    if not verificar_privilegios(LugarPublicacion::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear un lugar de publicacion!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @lugar_publicacion = LugarPublicacion.new(params[:lugar_publicacion])

      respond_to do |format|
        if @lugar_publicacion.save
          flash[:notice] = 'Se ha creado el lugar de publicación exitosamente.'
          format.html { redirect_to(@lugar_publicacion) }
          format.xml  { render :xml => @lugar_publicacion, :status => :created, :location => @lugar_publicacion }
        else
          flash[:notice] = '¡Surgió un error al crear el lugar de publicación!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @lugar_publicacion.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /lugar_publicacions/1
  # PUT /lugar_publicacions/1.xml
  def update
    if not verificar_privilegios(LugarPublicacion::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los lugares de publicaciones!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @lugar_publicacion = LugarPublicacion.find(params[:id])

      respond_to do |format|
        if @lugar_publicacion.update_attributes(params[:lugar_publicacion])
          flash[:notice] = 'Se ha actualizado el lugar de publicación exitosamente.'
          format.html { redirect_to(@lugar_publicacion) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar el lugar de publicación!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @lugar_publicacion.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /lugar_publicacions/1
  # DELETE /lugar_publicacions/1.xml
  def destroy
    if not verificar_privilegios(LugarPublicacion::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar los lugares de publicaciones!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @lugar_publicacion = LugarPublicacion.find(params[:id])
      @lugar_publicacion.destroy

      respond_to do |format|
        format.html { redirect_to(lugar_publicacions_url) }
        format.xml  { head :ok }
      end
    end
  end
end
