# coding: utf-8

# cambio_estado.rb
# Copyright (C) 2011  Giménez, Christian N.

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

# Martes 19 De Abril Del 2011    

class CambioEstado < ApplicationRecord
  #Privilegios:
  PuedeCrear = "Crear Cambios Estados"
  PuedeConsultar = "Consultar Cambios Estados"
  PuedeEditar ="Editar Cambios Estados"
  PuedeEliminar = "Eliminar Cambios Estados"

  belongs_to :norma
  belongs_to :causa_cambio_estado
  belongs_to :estado
end
