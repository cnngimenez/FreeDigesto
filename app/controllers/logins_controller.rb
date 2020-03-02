# -*- coding: utf-8 -*-

# logins_controller.rb
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


class LoginsController < ApplicationController
  
  skip_before_action :requerir_login, :only => [:new, :create]

  # GET /logins
  # GET /logins.json
  def index
    if not verificar_privilegios(Login::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los logins!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @logins = Login.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @logins }
      end
    end
  end

  # GET /logins/1
  # GET /logins/1.json
  def show
    if not verificar_privilegios(Login::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los logins!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @login = Login.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @login }
      end
    end
  end

  # GET /logins/new
  def new
    @login = Login.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @login }
    end
  end

  # GET /logins/1/edit
  def edit
    if not verificar_privilegios(Login::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los logins!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @login = Login.find(params[:id])
    end
  end

  # POST /logins
  # POST /logins.json
  def create
    @login = Login.new(params[:login])
    #devolver el user id en caso de que el login sea correct
    #nil en caso contrario.
    login = Login.autenticar(
      params[:login][:nombre_usuario],params[:login][:clave])

    if not login.nil?
      #Login correcto.
      bien = @login.save
    else
      #MAL :(
      flash[:notice] = "Usted NO ha podido ingresar al sistema :-("
      bien = false
    end

    #Grabar la sesión y el user id.
    session[:current_user_id] = login

    respond_to do |format|
      if bien
        flash[:notice] = "¡Usted está en el sistema!"
        format.html { redirect_to "/" }
        # format.xml  { render :xml => @login, :status => :created,
        #  :location => @login }
      else
        format.html { render :action => "new" }
        # format.xml  { render :xml => @login.errors,
        #  :status => :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /logins/1
  # PATCH/PUT /logins/1.json
  def update
    if not verificar_privilegios(Login::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los logins!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @login = Login.find(params[:id])

      respond_to do |format|
        if @login.update_attributes(params[:login])
          flash[:notice] = 'El Login ha sido actualizado con éxito.'
          format.html { redirect_to(@login) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar el Login!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @login.errors,
                               :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /logins/1
  # DELETE /logins/1.json
  def destroy
    @login = Login.find(params[:id])
    @login.destroy

    session[:current_user_id] = nil

    respond_to do |format|
      format.html { redirect_to "/"}
      format.xml  { head :ok }
    end
  end

end
