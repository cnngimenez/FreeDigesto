# -*- coding: utf-8 -*-

# agregar_privilegio.rb
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

class AgregarPrivilegio < ApplicationRecord
  #Privilegios:
  PuedeCrear = "Crear Agregar Privilegio"
  PuedeConsultar = "Consultar Agregar Privilegio"
  PuedeEditar ="Editar Agregar Privilegio"
  PuedeEliminar = "Eliminar Agregar Privilegio"

  belongs_to :privilegio
  belongs_to :patron_privilegio

  #Verificar que tiene un privilegio y un patrón de privilegios.
  validates :privilegio, presence: {
              message: "¡Debe escribir un privilegio!"
            }
  validates :patron_privilegio, presence: {
              message: "¡Debe escribir un patron de privilegios!"
            }

end
