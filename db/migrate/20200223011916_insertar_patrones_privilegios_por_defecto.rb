# coding: utf-8

class InsertarPatronesPrivilegiosPorDefecto < ActiveRecord::Migration[5.2]
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
    PatronPrivilegio.create(
      :nombre => "Consultor",
      :comentario => "Patron usado por los consultores. Sólo pude consultar" +
                    " normas y descriptores.")
    PatronPrivilegio.create(
      :nombre => "Data Entry",
      :comentario => "Patron usado para los data entry. Pueden consultar" +
                    " y guardar normas y descriptores")
  end

  def self.down
    PatronPrivilegio.delete_all
  end

  def change
  end
end
