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

end
