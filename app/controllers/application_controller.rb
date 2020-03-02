# coding: utf-8

# application_controller.rb
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


# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'd65e0aeec2a080b1a777d8b92ec96ce3'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like
  # "password").
  # filter_parameter_logging :password
  
  #### FILTRO PARA USUARIOS
  # Siempre que se quiera entrar a un a página, filtrar(ejecutar
  # requerir_login()).
  before_action :requerir_login

  protected
  
  #Determina si los privilegios son adecuados para ver la página actual.
  #Esta función debe ser editada por cada subclase(función polimórfica).
  def verificar_privilegios(accion)
    #Obtener si está esa acción en los privilegios del usuario.
    #Devolver verdadero si está, falso en caso contrario.

    #recordar que sessionid == userid
    sessionid = session[:current_user_id]
    if (sessionid.nil?)
      #Ingresó sin login... es el consultor
      session[:current_user_id] = Usuario.find_by_nombre("consultor")
      return TienePrivilegio.usuario_tiene_privilegio(
               accion,
               session[:current_user_id])
    end

    #Ingresó con login...
    return TienePrivilegio.usuario_tiene_privilegio(accion, sessionid)
  end

  private
  # Devuelve verdadero si ha iniciado sesión el usuario actual.
  # Si no hay una sesión iniciada, se la identificará cono el consultor.
  def usuario_actual
    if (session[:current_user_id].nil?)
      #Es nil la sesión actual: Entonces será el consultor...
      session[:current_user_id] = Usuario.find_by_nombre("consultor")
      @_usuario_actual ||= session[:current_user_id]
    else
      @_usuario_actual ||= session[:current_user_id] &&
                         Usuario.find(session[:current_user_id])
    end
  end

  # Función de filtrado para el usuario actual. Administra logins.
  def requerir_login
    unless logeado
      flash[:notice] = "¡Usted no está en el sistema!"
      redirect_to "/logins/new"
    end
  end

  # Devuelve verdadero cuando el usuario actual está logeado al servidor.
  def logeado
    !!usuario_actual
  end

  # Arma el Hash orden al momento de buscar los resultados
  #
  # *Entrada*
  # Un hash con los siguientes ítems:
  # - :tipo_orden => +ascendente+ o +descendente+
  # - :ordenar => _opción_
  #
  # Donde _opción_ puede ser:
  # - <tt>'numero'</tt>
  # - <tt>'fecha de sanción'</tt>
  # - <tt>'fecha de publicación'</tt>
  # - <tt>'fecha de promulgación'</tt>
  # - <tt>'fecha de creación'</tt>
  #
  # *Salida*
  # El hash que devuelve se compone de un sólo ítem que será el
  # necesario para ser aceptado por Norma.buscar_por_numero,
  # Norma.buscar_por_texto, etc.
  #
  # Ejemplos de salida:
  # - <tt>{:numero => 'ASC'}</tt>
  # - <tt>{:fecha_sancion => 'DESC'} </tt>
  # - <tt>{:fecha_promulgacion => 'ASC'} </tt>
  # - Etc.
  def armar_orden(params)
    orden = Hash.new()

    if params[:tipo_orden].nil? or
        params[:tipo_orden] == ""
        params[:tipo_orden] = 'ascendente'
        params[:ordenar] = 'fecha de sanción'
      end

      if params[:tipo_orden] == "ascendente"
        #Ordena ascendentemente
        tipo_orden = "ASC"
      else
        #oredena descendentemente
        tipo_orden = "DESC"
      end

      if params[:ordenar] == "numero"
        #Ordena según numero
        orden[:numero] = tipo_orden
      elsif params[:ordenar] == "fecha de promulgación"
        orden[:fecha_promulgacion] = tipo_orden
      elsif params[:ordenar] == "fecha de publicación"
        orden[:fecha_publicacion] = tipo_orden
      elsif params[:ordenar] == "fecha de creación"
        orden[:fecha_creacion] = tipo_orden
      else
        orden[:fecha_sancion] = tipo_orden
      end

    return orden
  end
  
end
