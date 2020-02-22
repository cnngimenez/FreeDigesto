# -*- coding: utf-8 -*-

    # application_helper.rb
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


# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Devuelve todos los estados de una norma ordenados según el nombre.
  #
  def get_estados
    @estados = Estado.find(:all, :order => "nombre")
  end

  # Devuelve todas las causas de cambios de estados ordenados según el nombre.
  #
  def get_causa_cambio_estados
    @causas = CausaCambioEstado.find(:all, :order => "nombre")
  end

  # Devuelve todos los tipos de normas ordenados según el nombre
  #
  def get_tipos_norma
    @tipos_norma = TipoNorma.find(:all, :order => "nombre")
  end

  # Devuevle todos los lugares de publicación ordenados según el nombre.
  #
  def get_lugares_publicacion
    @lugares_publicacion = LugarPublicacion.find(:all, :order => "nombre")
  end

  # Devuelve una colección de todos los patrones de privilegios que hay.
  # Se devolverán ordenados según el nombre.
  def get_patrones_privilegios
    return PatronPrivilegio.find(:all, :order => "nombre")
  end

  # Devuelve una colección de todos los privilegios ordenados según el nombre
  #
  def get_privilegios
    return Privilegio.find(:all, :order => "nombre")
  end

  # Devuelve todos los nombres de usuarios ordenados alfabéticamente.
  #
  def get_usuarios
    return Usuario.find(:all, :order => "nombre")
  end

  # Devuelve los tipos de las relaciones de normas ordenados según
  # el nombre.
  #
  def get_tipo_relaciones
    return TipoRelacion.find(:all, :order => "nombre")
  end

end
