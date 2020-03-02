# coding: utf-8

# tipo_relacion.rb
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

class TipoRelacion < ApplicationRecord
  #Privilegios:
  PuedeCrear = "Crear Tipos de Relaciones"
  PuedeConsultar = "Consultar Tipos de Relaciones"
  PuedeEditar ="Editar Tipos de Relaciones"
  PuedeEliminar = "Eliminar Tipos de Relaciones"
  
  #Vease el diagrama DIA y SQL
  has_many :relaciona_con_normas

  #Clave primaria es: nombre
  validates_presence_of :nombre, :message => "¡Debe escribir un nombre!"
  validates_uniqueness_of :nombre, :message => "¡Ese nombre ya existe!"
end
