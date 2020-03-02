# coding: utf-8

# relaciona_con_norma.rb
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

class RelacionaConNorma < ApplicationRecord
  #Privilegios:
  PuedeCrear = "Crear Relaciones con Normas"
  PuedeConsultar = "Consultar Relaciones con Normas"
  PuedeEditar ="Editar Relaciones con Normas"
  PuedeEliminar = "Eliminar Relaciones con Normas"

  #Vea el diagrama DIA y el SQL
  belongs_to :norma_a, :class_name => "Norma"
  belongs_to :norma_b, :class_name => "Norma"
  belongs_to :tipo_relacion

  # Claves primarias son las normaA_id y normaB_id.
  validates_presence_of(
    :norma_a_id,
    :message => "¡Debe escoger una norma \"inicial\" existente!")
  validates_presence_of(
    :norma_b_id,
    :message => "¡Debe escoger una norma \"final\" existente!")
  validates_uniqueness_of :norma_a_id,
                          :scope => [:norma_b_id],
                          :message => "¡Ya existe una relación con esas normas!"
  # Debe existir el tipo de relación que se está aplicando a ambas normas.
  validates_presence_of :tipo_relacion_id,
                        :message => "¡Debe asignar un tipo de relación!"

  
  # Devuelve todas las relaciones que estén entre norma ((|norma|)) y
  # cualquier otra.
  #
  # Busca tanto para norma_a sea igual a ((|norma|)) como para norma_b.
  #
  # Devuelve un arreglo con todos los "RelacionaConNorma".
  #
  def RelacionaConNorma::buscar_por_norma(norma)
    if norma.nil?
      return nil
    end
    return RelacionaConNorma.find(:all,
      :conditions =>
        "norma_a_id = " + norma.id.to_s + " OR
        norma_b_id = " + norma.id.to_s)
  end

  # Devuelve todas las relaciones que estén desde norma ((|norma|)) hasta
  # cualquier otra.
  #
  # Busca dentro de norma_a la norma ((|norma|)).
  # ((*No busca*)) en la norma_b.
  #
  # Devuelve un arreglo de todas las "relaciones con normas".
  #
  def RelacionaConNorma::buscar_relaciones_salientes(norma)
    if norma.nil?
      return nil
    end
    return RelacionaConNorma.find(:all,
      :conditions =>
        ["norma_a_id = ? ", norma.id])
  end

  # Devuelve todas las relaciones que partan de cualquiera hacia ((|norma|)).
  #
  # Busca dentro de norma_b a la norma ((|norma|)).
  # ((*No busca*)) en la norma_a.
  #
  # Devuelve un arreglo de todas las "RelacionaConNormas".
  #
  def RelacionaConNorma::buscar_relaciones_entrantes(norma)
    if norma.nil?
      return nil
    end
    return RelacionaConNorma.find(:all,
      :conditions =>
        ["norma_b_id = ?", norma.id])
  end

  # Elimino de mi tabla (_relaciona_con_norma_) todas las tuplas que
  # relacionen cualquier norma con la norma dada por el id +norma_id+ que
  # me es brindada por parámetro.
  #
  # En otras palabras, eliminaré las tuplas que posean en +norma_a+ y/o en
  # +norma_b+ el id dado por +norma_id+.
  #
  def RelacionaConNorma::eliminar_relaciones_por_norma(norma_id)
    RelacionaConNorma.delete_all(["norma_a_id = ? OR norma_b_id = ?",
                                  norma_id, norma_id])
  end

end
