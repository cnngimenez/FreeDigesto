# -*- coding: utf-8 -*-

    # login.rb
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


class Login < ActiveRecord::Base
  #Privilegios:
  #Puede crear? :-S O sea... puede entrar al sistema...
  #Mero formalismo
  PuedeCrear = "Crear Logins"
  PuedeConsultar = "Consultar Logins"
  PuedeEditar ="Editar Logins"
  PuedeEliminar = "Eliminar Logins"

  # Devuelve el id del usuario con nombre y clave, si y solo si
  # la clave corresponde con el usuario
  # Si el login con nombre de usuario "nombre" ya existe, entonces borrarlo.
  def Login.autenticar(nombre, clave)

    l = Usuario.find_by_nombre(nombre)

    #Si existe el usuario, y la contraseña es igual a la ingresada,devolver le id.
    if not l.nil? and (l.contrasena.eql?(clave) || l.contrasena.nil?)
      #Si existe el login borrarlo
      lstlogin = Login.find_all_by_nombre_usuario(nombre)
      if not lstlogin.nil?
        lstlogin.each do |login|
          login.destroy
        end
      end
      
      return l.id
    end

    #la contraseña y/o el usuario no concuerda... salir...
    return nil
  end
end
