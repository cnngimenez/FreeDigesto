# -*- coding: utf-8 -*-

# tiene_privilegio.rb
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

class TienePrivilegio < ApplicationRecord
  #Privilegios:
  PuedeCrear = "Crear Tiene Privilegios"
  PuedeConsultar = "Consultar Tiene Privilegios"
  PuedeEditar= "Editar Tiene Privilegios"
  PuedeEliminar = "Eliminar Tiene Privilegios"

  belongs_to :usuario
  belongs_to :privilegio

  # Validar que el usuario no tenga el privilegio ya creado
  validates_uniqueness_of :usuario_id, :scope => [:privilegio_id],
                          :message => 'Ese usuario ya tiene ese privilegio.'

end
