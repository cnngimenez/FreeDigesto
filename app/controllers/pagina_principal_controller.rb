# -*- coding: utf-8 -*-

# pagina_principal_controller.rb
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


class PaginaPrincipalController < ApplicationController

  # Devuelve si un usuario con privilegios lstPrivilegios puede administrar.
  def puede_administrar(lstPrivilegios)
    ## Cuales son los privilegios para administrar:
    lstadministrar = []
    lstadministrar.push(Usuario::PuedeCrear)
    lstadministrar.push(Usuario::PuedeEditar)
    lstadministrar.push(Usuario::PuedeConsultar)
    lstadministrar.push(Usuario::PuedeEliminar)

    lstadministrar.push(TienePrivilegio::PuedeCrear)
    lstadministrar.push(TienePrivilegio::PuedeEliminar)
    lstadministrar.push(TienePrivilegio::PuedeConsultar)
    lstadministrar.push(TienePrivilegio::PuedeEditar)

    return (lstPrivilegios & lstadministrar).length > 0
  end

  def index
    lsttiene_privilegios = TienePrivilegio.where(
      usuario_id: session[:current_user_id])
    @lstprivilegios = []

    lsttiene_privilegios.each{ |tienePriv|
      @lstprivilegios.push(tienePriv.privilegio.nombre)
    }

    #Puede consultar normas?
    @puede_consultar = @lstprivilegios.include?(Norma::PuedeConsultar)

    #Puede entrar datos?
    @puede_entrar_datos = @lstprivilegios.include?(Norma::PuedeCrear)

    #Puede administrar?    
    @puede_administrar = puede_administrar(@lstprivilegios)


    respond_to do |format|
      format.html
    end
  end
end
