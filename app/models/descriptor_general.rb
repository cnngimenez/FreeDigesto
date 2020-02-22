# -*- coding: utf-8 -*-

    # descriptor_general.rb
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


class DescriptorGeneral < ActiveRecord::Base
  # Privilegios:
  PuedeCrear = "Crear Descriptores Generales"
  PuedeConsultar = "Consultar Descriptores Generales"
  PuedeEditar = "Editar Descriptores Generales"
  PuedeEliminar = "Eliminar Descriptores Generales"

  #Vea el modelo DIA y SQL
  has_many :descriptor_particulars  
  has_many :posee_descriptors

  #Valida que se haya escrito el campo nombre y que sea único.
  validates_presence_of(:nombre, :message => "¡Debe escribir un nombre!")
  validates_uniqueness_of(:nombre, :message => "¡Ya existe ese nombre!");
end
