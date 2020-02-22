# coding: utf-8

    # insertar_agregar_privilegios_por_defecto.rb
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


class InsertarAgregarPrivilegiosPorDefecto < ActiveRecord::Migration
  def self.up
    down
    #Sin privilegios no se agrega nada aquí...

    #Root tiene todos los privilegios, así que, hay que agregar todos.
    #Buscar todos los privilegios, y por cada uno
    #crear un AgregarPrivilegio con el privilegio y el patrón asignados.
    lstprivs = Privilegio.all
    patron = PatronPrivilegio.find_by_nombre("Root")
    lstprivs.each{|priv|
      ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
      ap.save
    }

    # Consultor externo sólo tiene tres privilegios:
    # * Puede consultar normas
    # * Puede consultar descriptores
    # * Puede consultar descriptores particulares
    patron = PatronPrivilegio.find_by_nombre("Consultor")
    priv = Privilegio.find_by_nombre(Norma::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(DescriptorGeneral::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(DescriptorParticular::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save

    # Consultor interno puede consultar todo lo que necesite
    # * Puede consultar normas
    # * Puede consultar descriptores
    # * Puede consultar descriptores particulares
    # * Puede consultar los tipo de normas
    # * Puede consultar los estados
    # * Puede consultar los cambio_aplicado
    # * Puede consultar los cambio_estado
    # * Puede consultar causa_cambio_estado
    # * Puede consultar lugar de publicación
    # * Puede consultar posee_desc_part
    # * Puede consultar posee_descriptor
    # * Puede consultar relaciona_con_norma
    # * Puede consultar tipo_relacion
    patron = PatronPrivilegio.find_by_nombre("Consultor Interno")
    # Consultar normas
    priv = Privilegio.find_by_nombre(TipoNorma::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(Norma::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    # Consultar descriptores
    priv = Privilegio.find_by_nombre(DescriptorGeneral::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(DescriptorParticular::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    # Consultar vencimientos y cambios de estados
    priv = Privilegio.find_by_nombre(CambioAplicado::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(CambioEstado::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(CausaCambioEstado::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    # Consultar elementos de las normas
    priv = Privilegio.find_by_nombre(Estado::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(LugarPublicacion::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    # Consultar descriptores generales y particulares
    priv = Privilegio.find_by_nombre(PoseeDescPart::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(PoseeDescriptor::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    # Consultar relaciones entre las normas
    priv = Privilegio.find_by_nombre(RelacionaConNorma::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(TipoRelacion::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save

    #Data entry tiene los mismos privilegios que el consultor y se agregan:
    # * Puede agregar normas
    # * Puede consultar (como el consultor interno) y agregar los "cambio norma"

    # Privilegios para consultar
    patron = PatronPrivilegio.find_by_nombre("Data Entry")
    # Consultar normas
    priv = Privilegio.find_by_nombre(TipoNorma::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(Norma::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    # Consultar descriptores
    priv = Privilegio.find_by_nombre(DescriptorGeneral::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(DescriptorParticular::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    # Consultar vencimientos y cambios de estados
    priv = Privilegio.find_by_nombre(CambioAplicado::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(CambioEstado::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(CausaCambioEstado::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    # Consultar elementos de las normas
    priv = Privilegio.find_by_nombre(Estado::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(LugarPublicacion::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    # Consultar descriptores generales y particulares
    priv = Privilegio.find_by_nombre(PoseeDescPart::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(PoseeDescriptor::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    # Consultar relaciones entre las normas
    priv = Privilegio.find_by_nombre(RelacionaConNorma::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(TipoRelacion::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save

    # Privilegios para la creación de normas
    priv = Privilegio.find_by_nombre(Norma::PuedeCrear)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(PoseeDescriptor::PuedeCrear)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(PoseeDescPart::PuedeCrear)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save

    #Privilegios para los vencimientos
    priv = Privilegio.find_by_nombre(CambioEstado::PuedeCrear)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by_nombre(CambioAplicado::PuedeCrear)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save

    # Privilegios para crear relaciones entre las normas
    priv = Privilegio.find_by_nombre(RelacionaConNorma::PuedeCrear)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id, :patron_privilegio_id => patron.id)
    ap.save

  end

  def self.down
    AgregarPrivilegio.delete_all
  end
end
