# coding: utf-8

# asignar_privilegios_controller.rb
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

# Domingo 17 De Octubre Del 2010    

# Controlador para asignar privilegios a un usuario
# Este controlador le da una pantalla de bienvenida y
# le indica al usuario qué tipo de patrón desea agregar.

class AsignarPrivilegiosController < ApplicationController

  def index
    if not verificar_privilegios(TienePrivilegio::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar privilegios a un usuario!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      if (params[:usr_id].nil? or params[:usr_id] == '' )
        @usuario = nil
      else
        @usuario = Usuario.find(params[:usr_id])
      end
      

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @agregar_privilegios }
      end
    end
  end

  # Asigna un patrón a un usuario.
  # Si ya se eligió un usuario, puede pasar por #usr_id el id del usuario
  # Si no, se presentará un listbox para elegirlo
  def asignar_patron
    if not verificar_privilegios(TienePrivilegio::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar privilegios a un usuario!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      if (params[:usr_id].nil? or params[:usr_id] == '' )
        #No ha designado un usuario
        @usuario = nil
      else
        #Ha designado un usuario
        @usuario = Usuario.find(params[:usr_id])
      end


      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @asignar_patron }
      end
    end
  end

  # Le asigna al usuario ((|usuario|)) los privilegios que posee
  # el patrón ((|patron|)).
  #
  # Busca en "agregar_privilegios" los privilegios correspondientes
  # al patron dado y se los asigna al usuario.
  #
  def aplicar_privilegios(usuario, patron)

    #Obtener todos los ids de los privilegios...
    lstagregar_privs = patron.agregar_privilegios

    flash[:notice] = ""

    lstagregar_privs.each do |agregar_priv|
      tiene_priv = TienePrivilegio.new()
      tiene_priv.privilegio = agregar_priv.privilegio
      tiene_priv.usuario = usuario
      tiene_priv.save
    end
  end

  def agregar_privilegios
    if not verificar_privilegios(TienePrivilegio::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar privilegios a un usuario!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      if (params[:usr_id].nil? or params[:usr_id] == '' )
        #No designo un usuario usando parametros... buscar por formulario
        if (params[:patron][:usr_id].nil? or params[:patron][:usr_id] == '')
          #Ningún usuario designado, ¡ni usando GET ni POST!... alertar
          flash[:notice] = "¡Debe seleccionar un usuario!"
          respond_to do |format|
            format.html {redirect_to(:controller => "pagina_principal")}
          end
        else
          #Lo designo por formulario... usar ese...
          @usuario = Usuario.find(params[:patron][:usr_id])
          @patron = PatronPrivilegio.find(params[:patron][:patron_id])
          aplicar_privilegios(@usuario, @patron)
        end
      else
        #si designo un usuario
        @usuario = Usuario.find(params[:usr_id])
        @patron = PatronPrivilegio.find(params[:patron][:patron_id])
        aplicar_privilegios(@usuario, @patron)
      end


      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @agregar_privilegios }
      end
    end
  end

end
