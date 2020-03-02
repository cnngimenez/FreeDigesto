# -*- coding: utf-8 -*-

# lugar_publicacion.rb
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

class LugarPublicacion < ApplicationRecord
  #Privilegios:
  PuedeCrear = "Crear Lugar de Publicaciones"
  PuedeConsultar = "Consultar Lugar de Publicaciones"
  PuedeEditar = "Editar Lugar de Publicaciones"
  PuedeEliminar = "Eliminar Lugar de Publicaciones"
  
  #Vea el modelo DIA y SQL
  has_many :normas

  #Valida que tenga un nombre y que sea único.
  validates_presence_of(:nombre, :message => "¡Debe escribir un nombre!")
  validates_uniqueness_of(:nombre, :message => "¡Ese nombre ya existe!")
end
