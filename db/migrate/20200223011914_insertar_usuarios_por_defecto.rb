# coding: utf-8

# insertar_usuarios_por_defecto.rb
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

class InsertarUsuariosPorDefecto < ActiveRecord::Migration[5.2]
  def self.up
    down

    Usuario.create nombre: "root", contrasena: "root"    
    Usuario.create nombre: "consultor", contrasena: ""
  end

  def self.down
    Usuario.delete_all
  end
end
