# coding: utf-8

# causa_cambio_estado.rb
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

class CausaCambioEstado < ApplicationRecord
  #Privilegios:
  PuedeCrear = "Crear Causas de Cambios de Estados"
  PuedeConsultar = "Consultar Causas de Cambios de Estados"
  PuedeEditar ="Editar Causas de Cambios de Estados"
  PuedeEliminar = "Eliminar Causas de Cambios de Estados"

  AplicadoPorUsuario = "Aplicado por el Usuario"

  #Vea el diagrama DIA y el SQL
  has_many :cambio_estados

  #Clave primaria es: nombre
  validates_presence_of :nombre, :message => "¡Debe escribir un nombre!"
  validates_uniqueness_of :nombre, :message => "¡Ese nombre ya existe!"


  # Crea la causa de cambio de estado "Aplicado por el Usuario" si
  # esta no existe.
  #
  # Devuelve nil si ya existía. La causa recién creada en caso contrario.
  def CausaCambioEstado::crear_aplicado_por_usuario()
    cce = nil
    if self.where(["nombre = ?", AplicadoPorUsuario]).first.nil?
      cce = CausaCambioEstado.new()
      cce.nombre = CausaCambioEstado::AplicadoPorUsuario;
      cce.comentario = ""
      cce.save
    end

    return cce
  end

end
