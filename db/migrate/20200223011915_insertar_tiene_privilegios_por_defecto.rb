# coding: utf-8

# insertar_tiene_privilegios_por_defecto.rb
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

class InsertarTienePrivilegiosPorDefecto < ActiveRecord::Migration[5.2]
  def self.up
    down
    #Privilegios de Root por defecto
    usuarioroot = Usuario.find_by nombre: "root"

    #Puede hacer todo :P
    priv_id = Privilegio.all

    priv_id.each {|p|
      priv = TienePrivilegio.new(:usuario_id => usuarioroot.id,
                                 :privilegio_id => p.id)
      priv.save
    }


    #Privilegios del Consultor por defecto.
    consultor = Usuario.find_by nombre: "consultor"

    #Puede consultar las normas
    privilegio = Privilegio.find_by nombre: Norma::PuedeConsultar

    if (not privilegio.nil?)
      priv = TienePrivilegio.new(:usuario_id => consultor.id,
                                 :privilegio_id => privilegio.id)
      priv.save
    end

    #Puede consultar los descriptores.
    privilegio = Privilegio.find_by nombre: DescriptorGeneral::PuedeConsultar

    if (not privilegio.nil?)
      priv = TienePrivilegio.new(:usuario_id => consultor.id,
                                 :privilegio_id => privilegio.id)
      priv.save
    end

    privilegio = Privilegio.find_by nombre: DescriptorParticular::PuedeConsultar

    if (not privilegio.nil?)
      priv = TienePrivilegio.new(:usuario_id => consultor.id,
                                 :privilegio_id => privilegio.id)
      priv.save
    end
  end

  def self.down
    TienePrivilegio.delete_all
  end

  def change
  end
end
