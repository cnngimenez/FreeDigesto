# -*- coding: utf-8 -*-

# posee_descriptor.rb
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

class PoseeDescriptor < ApplicationRecord
  #Privilegios:
  PuedeCrear = "Crear Posee Descriptores"
  PuedeConsultar = "Consultar Posee Descriptores"
  PuedeEditar = "Editar Posee Descriptores"
  PuedeEliminar = "Eliminar Posee Descriptores"

  belongs_to :norma
  belongs_to :descriptor_general

  #Valida que se haya seleccionado una norma y un descriptor general.
  validates_presence_of(:norma, :message => "¡Debe escribir una norma válida!")
  validates_presence_of(
    :descriptor_general,
    :message => "¡Debe seleccionar un descriptor general válido")
  #Verificar que sólo haya una relación de una norma a un descriptor general.
  #Contra-ejemplo:
  #  norma1 => descGen1  (BIEN HASTA AQUÍ)
  #  norma1 => descGen2  (BIEN)
  #  norma1 => descGen1  (¡MAL! ¡YA EXISTE!)
  validates_uniqueness_of(
    :norma_id,
    :scope => [:descriptor_general_id],
    :message => "¡Sólo una norma con un descriptor!")


  # Elimino todas las tuplas de mi tabla(_posee_descriptor_) que estén
  # relacionadas con la norma dada por +norma_id+.
  # En otras palabras, elimino las tuplas que posean como valor para el campo
  # "_norma_id_" el id dado por el parámetro +norma_id+.
  #
  def PoseeDescriptor::eliminar_relaciones_por_norma(norma_id)
    PoseeDescriptor.delete_all(["norma_id = ?", norma_id])
  end

end
