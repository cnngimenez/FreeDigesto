# -*- coding: utf-8 -*-

    # posee_desc_part.rb
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


class PoseeDescPart < ActiveRecord::Base
  #Privilegios:
  PuedeCrear = "Crear Posee DescParts"
  PuedeConsultar = "Consultar Posee DescParts"
  PuedeEditar = "Editar Posee DescParts"
  PuedeEliminar = "Eliminar Posee DescParts"

  #Vea el diagrama DIA y SQL
  belongs_to :norma
  belongs_to :descriptor_particular

  #Verificar que tenga una norma y un descriptor particular.
  validates_presence_of(:norma, :message => "¡Debe escribir una norma válida")
  validates_presence_of(:descriptor_particular , :message => "¡Debe escribir un descriptor válido!")
  #Verificar que sólo haya una relación de una norma a un descriptor particular.
  #Contra-ejemplo:
  #  norma1 => descPart1  (BIEN HASTA AQUÍ)
  #  norma1 => descPart2  (BIEN)
  #  norma1 => descPart1  (¡MAL! ¡YA EXISTE!)
  validates_uniqueness_of(:norma_id, :scope => [:descriptor_particular_id],
    :message => "¡Ya existe esa norma relacionada con ese descriptor!")

  # Busco los posee_desc_parts correspondientes a esa norma cuyos descriptores particulares
  # pertenezcan a ese descriptor general.
  #
  # Devuelvo un Array que tienen posee_desc_parts.
  def PoseeDescPart::buscar_por_dg_norma(norma_id, desc_gen_id)
    # No olvidar que si no se incorpora en el select lo siguiente: "SELECT posee_desc_parts"
    # puede devolver mal los datos, principalmente aquellos cuyos campos sean de nombres
    # idénticos.
    # Asegurarse que los datos que devuelve un "SELECT * ..." sean correctos.
    # En este caso, no lo son pues si no se hubiese corregido este select, devolvería el
    # id de posee_descriptor con el mismo número que el id del descriptor particular.
    PoseeDescPart.find(:all,
      :select => "posee_desc_parts.*",
      :conditions => "norma_id = " + norma_id.to_s + " AND
descriptor_particular_id = descriptor_particulars.id AND
descriptor_particulars.descriptor_general_id = " + desc_gen_id.to_s,
      :from => "posee_desc_parts, descriptor_particulars")
  end

  # Elimino todas las tuplas de mi tabla(_posee_desc_part_) que estén relacionadas con
  # la norma dada por +norma_id+.
  # En otras palabras, elimino las tuplas que posean como valor para el campo
  # "_norma_id_" el id dado por el parámetro +norma_id+.
  #
  def PoseeDescPart::eliminar_relaciones_por_norma(norma_id)
    PoseeDescPart.delete_all(["norma_id = ?",norma_id])
  end
end
