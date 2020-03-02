# -*- coding: utf-8 -*-

# descriptor_particular.rb
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

class DescriptorParticular < ApplicationRecord
  #Privilegio:
  PuedeCrear = "Crear Descriptores Particulares"
  PuedeConsultar = "Consultar Descriptores Particulares"
  PuedeEditar = "Editar Descriptores Particulares"
  PuedeEliminar = "Eliminar Descriptores Particulares"

  belongs_to :descriptor_general

  has_many :posee_desc_parts

  #Valida que el nombre esté escrito
  validates_presence_of(:nombre, :message => "¡Debe escribir un nombre!")
  #Valida que el descriptor general haya sido seleccionado
  validates_presence_of(
    :nombre_descriptor_general => "¡Debe seleccionar un descriptor general!")

end
