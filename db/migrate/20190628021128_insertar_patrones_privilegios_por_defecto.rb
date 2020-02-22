# coding: utf-8

    # insertar_patrones_privilegios_por_defecto.rb
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


class InsertarPatronesPrivilegiosPorDefecto < ActiveRecord::Migration
  def self.up
    down
    #Hay tres patrones de privilegios que tiene FreeDigesto por defecto:
    # * Sin privilegios
    # * Root
    # * Consultor

    PatronPrivilegio.create(:nombre => "Sin privilegios",
      :comentario => "Patron sin ningún privilegio")
    PatronPrivilegio.create(:nombre => "Root",
      :comentario => "Patron usado por el administrador root")
    PatronPrivilegio.create(:nombre => "Consultor",
      :comentario => "Patron usado por los consultores externos al Concejo. Sólo pude consultar normas y descriptores.")
    PatronPrivilegio.create(:nombre => "Consultor Interno",
                            :comentario => "Patron usado por los consultores internos al Concejo(por ejemplo secretarias, personas que integran el staff). Pueden consultar lo que deseen, pero no pueden modificar nada.")
    PatronPrivilegio.create(:nombre => "Data Entry",
      :comentario => "Patron usado para los data entry. Pueden consultar y guardar normas y descriptores")
  end

  def self.down
    PatronPrivilegio.delete_all
  end
end
