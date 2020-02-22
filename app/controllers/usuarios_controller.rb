# -*- coding: utf-8 -*-

    # usuarios_controller.rb
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


class UsuariosController < ApplicationController
  # GET /usuarios
  # GET /usuarios.xml
  def index
    if not verificar_privilegios(Usuario::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar usuarios!"      
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

      else
      #Si tiene derechos...
      @usuarios = Usuario.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @usuarios }
      end
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.xml
  def show
    if not verificar_privilegios(Usuario::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar usuarios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

      else
      @usuario = Usuario.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @usuario }
      end
    end
  end
  # GET /usuarios/new
  # GET /usuarios/new.xml
  def new
    if not verificar_privilegios(Usuario::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear usuarios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

      else
      @usuario = Usuario.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @usuario }
      end
    end
  end

  # GET /usuarios/1/edit
  def edit
    if not verificar_privilegios(Usuario::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar usuarios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

      else
      @usuario = Usuario.find(params[:id])
    end
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create
    if not verificar_privilegios(Usuario::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear usuarios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

      else
      @usuario = Usuario.new(params[:usuario])

      respond_to do |format|
        if @usuario.save
          flash[:notice] = 'El usuario ha sido creado exitósamente.'
          format.html { redirect_to(@usuario) }
          format.xml  { render :xml => @usuario, :status => :created, :location => @usuario }
        else
          flash[:notice] = '¡Surgió un error al crear el usuario!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
    if not verificar_privilegios(Usuario::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar usuarios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

      else
      @usuario = Usuario.find(params[:id])

      respond_to do |format|
        if @usuario.update_attributes(params[:usuario])
          flash[:notice] = 'Se ha actualizado los datos del usuario correctamente.'
          format.html { redirect_to(@usuario) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar los datos del usuario!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.xml
  def destroy
    if not verificar_privilegios(Usuario::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar usuarios!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

      else
      @usuario = Usuario.find(params[:id])
      @usuario.destroy

      respond_to do |format|
        format.html { redirect_to(usuarios_url) }
        format.xml  { head :ok }
      end
    end
  end
end
