# coding: utf-8

    # cambio_aplicado.rb
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


class CambioAplicado < ActiveRecord::Base
  #Privilegios:
  PuedeCrear = "Crear Cambios Aplicados"
  PuedeConsultar = "Consultar Cambios Aplicados"
  PuedeEditar ="Editar Cambios Aplicados"
  PuedeEliminar = "Eliminar Cambios Aplicados"

  #Formas de ordenar
  PorFechaAplicado = "fecha_aplicado"
  PorFechaCambio = "cambio_estados.fecha_cambio"
  PorFechaCreacion = "cambio_estados.fecha_creacion"

  Descendente = "DESC"
  Ascendente = "ASC"

  #Vea el diagrama DIA y el SQL
  belongs_to :cambio_estado

  #Clave primaria son fecha_aplicado y cambio_estado_id
  validates_presence_of :fecha_aplicado, :message => "¡Debe haber una fecha de aplicado!"
  validates_presence_of :cambio_estado_id, :message => "¡Debe haber un cambio de estado!"
  validates_uniqueness_of :fecha_aplicado,
    :scope => [:cambio_estado_id],
    :message => "¡Ya existe la fecha de aplicado con ese cambio de estado!"


  # Devuelve todos los cambios aplicados de la norma dada
  #
  #  El orden de los elementos depende de ((|orden|)) y ((|desc_asc|)).
  #  Opciones disponibles para ((|orden|)) son:
  #   * CambioAplicado::PorFechaAplicado: Según la fecha en que el cambio se aplicó.
  #   * CambioAplicado::PorFechaCambio: Según la fecha en que se planificó el cambio
  #   * CambioAplicado::PorFechaCreacion: Según la fecha en que se creó la planificación.
  #  Opciones disponibles para ((|desc_asc|)) son:
  #   * CambioAplicado::Descendente
  #   * CambioAplicado::Ascendente
  #
  def CambioAplicado::obtener_cambios_aplicados(norma, orden, desc_asc)
    # SELECT * FROM cambio_aplicados, cambio_estados
    # WHERE
    #   cambio_estados.norma_id = normaid AND
    #   cambio_estados.id = cambio_aplicados.cambio_estado_id
    # GROUP BY cambio_aplicados.id
    # ORDER BY orden  desc_asc
    #
    return CambioAplicado.find(:all,
      :select => "cambio_aplicados.*",
      :conditions => "cambio_estados.norma_id = " + norma.id.to_s +
        " AND cambio_estados.id = cambio_aplicados.cambio_estado_id",
      :order => orden + " " + desc_asc,
      :group => ["cambio_aplicados.id"],
      :from => "cambio_aplicados, cambio_estados")
  end

  # Devuelve verdadero si el cambio de estado fue instantáneo
  # o sea, si la fecha de creación del cambio de estado es igual
  # a la fecha de aplicado del cambio.
  #
  # El cambio instantáneo significa que no fue un cambio de estado
  # planificado que luego se aplicó, sino que el usuario cambió
  # el estado de una norma sin planearlo.
  #
  def es_cambio_instantaneo()
    return (self.fecha_aplicado <=> self.cambio_estado.fecha_creacion) == 0
  end
end
