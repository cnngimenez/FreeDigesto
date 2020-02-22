# -*- coding: utf-8 -*-

# norma.rb
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

class Norma < ApplicationRecord
  # Privilegios:
  PuedeCrear = "Crear Normas"
  PuedeEditar = "Editar Normas"
  PuedeEliminar = "Eliminar Normas"
  PuedeConsultar = "Consultar Normas"

  #Mirar el modelo DIA y SQL
  #La norma ya no posee el atributo estado desde las versiones 1.4 en adelante...
  # belongs_to :estado
  belongs_to :tipo_norma
  belongs_to :lugar_publicacion

  #Valida la presencia de los campos número de norma, sumario y texto.
  #¡numero de norma y el tipo son claves primarias!
  validates_presence_of(:numero, :message => "¡Debe escribir un número!")
  validates_presence_of(:tipo_norma_id,
                        :message => "¡Debe escojer un tipo de norma!")

  validates_presence_of(:sumario,
                        :message => "¡Debe escribir un sumario!")
  #No necesariamente puede tener un texto.
  #validates_presence_of(:texto, :message => "¡Debe escribir un texto!")


  #La norma ya no posee el atributo estado desde las versiones 1.4 en adelante...
  #validates_presence_of(:estado, :message => "¡Debe escojer un estado!")
  validates_presence_of(:lugar_publicacion,
                        :message => "¡Debe escojer un lugar de publicacion!")

  # ¿es necesario las validaciones estas?
  # NOP... Pues se utiliza un tipo de listado para buscarlos...
  # Igualmente sería útil para evitar un POST inadecuado y hacer que la
  # base de datos
  # no posea valores inadecuados.
  # ¡Lo útil sería armar la base de datos como corresponde! Pero bueno :-S
  #
  # Valida que el campo Tipo_norma sea una entrada de la tabla "tipo_norma"
  # validates_inclusion_of(:tipo_norma,
  #  :in => TipoNorma.find(:all),
  #  :message => "¡Tipo de norma inválido!")

  # Valida que el campo Lugar_publicacion sea una entrada de la tabla
  # "lugar_publicacion".
  # validates_inclusion_of(:lugar_publicacion,
  #  :in => LugarPublicacion.find(:all),
  #  :message => "¡El lugar de la publicación no es válido!")


  # Valida que el campo Estado sea una entrada de la tabla "estados"
  # validates_inclusion_of(:estado,
  #   :in => Estado.find(:all),
  #   :message => "¡El estado no es válido!")

  # Valida que el número de norma sea único y no se repita en la tabla
  # No poner validates_uniqueness_of(:numero, :tipo_norma_id, ...
  # pues verifica la uniquidad en los dos:
  # Ej.:
  # Norma1 Tipo1
  # Norma2 Tipo1 -> ¡Error! ¡Porque "Tipo1" no es único!
  validates_uniqueness_of(:numero, :scope => [:tipo_norma_id],
                          :message => "¡Ese número de norma ya existe!")

end
