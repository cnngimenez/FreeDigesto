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

  #Formas de ordena la salida
  PorFechaCambio = "fecha_cambio"
  PorFechaCreacion = "fecha_creacion"
  PorNormaId = "norma_id"

  Descendente = "DESC"
  Ascendente = "ASC"
  
  #Vea el diagrama DIA y el SQL
  has_one :cambio_aplicado
  belongs_to :norma
  belongs_to :causa_cambio_estado
  belongs_to :estado

  #claves primarias son: fecha_cambio, norma_id
  validates_uniqueness_of(
    :norma_id, :scope => [:fecha_cambio],
    :message => "¡Esa fecha de cambio para esa norma ya existe!")
  validates_presence_of :fecha_cambio,
                        :message => "¡Debe ingresar una fecha de cambio!"
  validates_presence_of(
    :norma_id,
    :message => "¡Debe asignar una norma a este cambio de estado!")
  #¡deben estar también el estado y la causa!
  validates_presence_of :estado_id,
                        :message => "¡Debe elegir un estado!"
  validates_presence_of(
    :causa_cambio_estado_id,
    :message => "¡Debe elegir una causa de cambio de estado!")


  # Devuelve el último cambio de estado que se aplicó para la norma |norma|.
  #
  def CambioEstado::obtener_estado_actual(norma)
    # Hay que usar find_by_sql lamentablemente ... 
    ce = CambioEstado.find_by_sql(
      "SELECT cambio_estados.* FROM cambio_estados, cambio_aplicados
      WHERE
          norma_id = " + norma.id.to_s + " AND
          cambio_aplicados.cambio_estado_id = cambio_estados.id      
      ORDER BY cambio_aplicados.fecha_aplicado DESC
      LIMIT 1" )

    if ce.first().nil?
      #¡Algo falló!
      return nil
    else
      return ce.first()
    end
  end

  # Devuelve los estados programados y aplicados, inclusive los cambios
  # de estados instantaneos(con fecha de creacion igual al de aplicacion).
  #
  # Los cambios de estados se ordenan del mas reciente al mas antiguo, por lo
  # que el primer elemento del arreglo es el estado actual.
  #
  # Ejemplo:
  # Para obtener el estado actual:
  # CambioEstado.obtener_estados_aplicados(norma).first
  #
  # TODO: Testear!
  #
  def CambioEstado::obtener_cambio_estados_aplicados(norma)
    # SELECT cambio_estados.* FROM cambio_estados, cambio_aplicados, estados
    # WHERE
    #   norma_id = normaid AND
    #   cambio_aplicados.id = cambio_estados.id AND
    #   cambio_aplicados.fecha_aplicado = fecha_creacion AND
    #   estados.id = cambio_estados.estado_id
    # GROUP BY norma_id
    # ORDER BY fecha_creacion DESC
    #
    CambioEstado.select('cambio_estados.*')
                .where([
                         'norma_id = ? AND cambio_aplicados.id = cambio_estados.id AND ' \
                         'cambio_aplicados.fecha_aplicado = fecha_creacion AND ' \
                         'estados.id = cambio_estados.estado_id',
                         norma.id.to_s
                       ])
                .group(['norma_id'])
                .order(fecha_creacion: :desc)
                .from('cambio_estados, cambio_aplicados,estados')
                .all
  end

  # Devuelve todos los cambios de estados programados de una norma,
  # sean aplicados o no aplicados.
  #
  # Devuelve en forma de Array ordenado segun |orden| y |desc_asc|
  # Los valores posibles para |orden| son las constantes:
  #   * CambioEstado::PorFechaCambio
  #   * CambioEstado::PorFechaCreacion
  #   * CambioEstado::PorNormaId
  # Los valores posibles para |desc_acs| son
  #   * CambioEstado::Descendente
  #   * CambioEstado::Ascendente
  #
  def CambioEstado::obtener_cambio_estados(norma,orden,desc_asc)
    return nil if orden.nil? || desc_asc.nil?

    # SELECT * FROM cambio_estados
    # WHERE
    #   norma_id = normaid
    # ORDER BY orden desc_asc
    #

    CambioEstado.where(['norma_id = ?', norma.id])
                .order("#{orden} #{desc_asc}")
                .all
  end

  # Devuelve los cambios de estados que estén a punto de vencer con
  # |dias| de anticipación.
  #
  def CambioEstado::obtener_a_vencer(dias)
    vencimiento = Time.now + dias * 24 * 60 * 60

     return CambioEstado.find_by_sql("
      SELECT * FROM cambio_estados ce
      WHERE        
        ce.id NOT IN
          (SELECT cambio_estado_id FROM cambio_aplicados
          WHERE
            ce.id = cambio_aplicados.cambio_estado_id) AND
        ce.fecha_cambio <= \"" + vencimiento.strftime("%Y-%m-%d") + "\"")
  end

  # Elimino de mi tabla todos los cambios de estados que sean de la norma
  # cuyo id sea +norma_id+.
  #
  # Tambien elimino los cambios aplicados si es que poseen tales cambios.
  #
  def CambioEstado::eliminar_relaciones_por_norma(norma_id)
    # Buscar los cambios de estados que esten relacionados con la norma
    lst_cambios = CambioEstado.where(['norma_id = ?', norma_id]).all

    # Borrar los cambios_aplicados si tiene y el cambio de estado de la lista.
    lst_cambios.each do |cambio_estado|
      # Aparentemente puede haber mas de un cambio_aplicado, pero en el
      # diseno(MER) esta esclarecido que esto no se debe hacer.
      # Sin embargo, es mas eficiente un "delete_all" que un "destroy".
      CambioAplicado.delete_all(['cambio_estado_id = ?', cambio_estado.id])
      cambio_estado.destroy
    end
  end
end
