# coding: utf-8

# insertar_privilegios_por_defecto.rb
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

class InsertarPrivilegiosPorDefecto < ActiveRecord::Migration[5.2]
  def self.down
    Privilegio.delete_all
  end

  def self.up
    down
    # Para los usuarios
    crearPrivilegio(Usuario::PuedeConsultar)
    crearPrivilegio(Usuario::PuedeCrear)
    crearPrivilegio(Usuario::PuedeEditar)
    crearPrivilegio(Usuario::PuedeEliminar)

    # Para las normas
    crearPrivilegio(Norma::PuedeCrear)
    crearPrivilegio(Norma::PuedeEditar)
    crearPrivilegio(Norma::PuedeEliminar)
    crearPrivilegio(Norma::PuedeConsultar)

    # descriptor_general
    crearPrivilegio(DescriptorGeneral::PuedeCrear)
    crearPrivilegio(DescriptorGeneral::PuedeConsultar)
    crearPrivilegio(DescriptorGeneral::PuedeEditar)
    crearPrivilegio(DescriptorGeneral::PuedeEliminar)

    # descriptor_particulars
    crearPrivilegio(DescriptorParticular::PuedeCrear)
    crearPrivilegio(DescriptorParticular::PuedeConsultar)
    crearPrivilegio(DescriptorParticular::PuedeEditar)
    crearPrivilegio(DescriptorParticular::PuedeEliminar)

    # estados
    crearPrivilegio(Estado::PuedeCrear)
    crearPrivilegio(Estado::PuedeConsultar)
    crearPrivilegio(Estado::PuedeEditar)
    crearPrivilegio(Estado::PuedeEliminar)

    # lugar_publicacions
    crearPrivilegio(LugarPublicacion::PuedeCrear)
    crearPrivilegio(LugarPublicacion::PuedeConsultar)
    crearPrivilegio(LugarPublicacion::PuedeEditar)
    crearPrivilegio(LugarPublicacion::PuedeEliminar)

    # posee_desc_parts
    crearPrivilegio(PoseeDescPart::PuedeCrear)
    crearPrivilegio(PoseeDescPart::PuedeConsultar)
    crearPrivilegio(PoseeDescPart::PuedeEditar)
    crearPrivilegio(PoseeDescPart::PuedeEliminar)

    # posee_descriptors
    crearPrivilegio(PoseeDescriptor::PuedeCrear)
    crearPrivilegio(PoseeDescriptor::PuedeConsultar)
    crearPrivilegio(PoseeDescriptor::PuedeEditar)
    crearPrivilegio(PoseeDescriptor::PuedeEliminar)

    # privilegios
    # Para qué?
    crearPrivilegio(Privilegio::PuedeCrear)
    crearPrivilegio(Privilegio::PuedeConsultar)
    crearPrivilegio(Privilegio::PuedeEditar)
    crearPrivilegio(Privilegio::PuedeEliminar)

    # tipo_normas
    crearPrivilegio(TipoNorma::PuedeCrear)
    crearPrivilegio(TipoNorma::PuedeConsultar)
    crearPrivilegio(TipoNorma::PuedeEditar)
    crearPrivilegio(TipoNorma::PuedeEliminar)

    # tiene_privilegios
    crearPrivilegio(TienePrivilegio::PuedeCrear)
    crearPrivilegio(TienePrivilegio::PuedeConsultar)
    crearPrivilegio(TienePrivilegio::PuedeEditar)
    crearPrivilegio(TienePrivilegio::PuedeEliminar)

    # logins
    # De aquí sólo es útil "PuedeEliminar" y "PuedeConsultar"
    crearPrivilegio(Login::PuedeCrear)
    crearPrivilegio(Login::PuedeConsultar)
    crearPrivilegio(Login::PuedeEditar)
    crearPrivilegio(Login::PuedeEliminar)

    # patron_privilegios
    crearPrivilegio(PatronPrivilegio::PuedeCrear)
    crearPrivilegio(PatronPrivilegio::PuedeConsultar)
    crearPrivilegio(PatronPrivilegio::PuedeEditar)
    crearPrivilegio(PatronPrivilegio::PuedeEliminar)

    # agregar_privilegios
    crearPrivilegio(AgregarPrivilegio::PuedeCrear)
    crearPrivilegio(AgregarPrivilegio::PuedeConsultar)
    crearPrivilegio(AgregarPrivilegio::PuedeEditar)
    crearPrivilegio(AgregarPrivilegio::PuedeEliminar)

    # cambio_aplicados
    crearPrivilegio(CambioAplicado::PuedeCrear)
    crearPrivilegio(CambioAplicado::PuedeConsultar)
    crearPrivilegio(CambioAplicado::PuedeEditar)
    crearPrivilegio(CambioAplicado::PuedeEliminar)

    # cambio_estados
    crearPrivilegio(CambioEstado::PuedeCrear)
    crearPrivilegio(CambioEstado::PuedeConsultar)
    crearPrivilegio(CambioEstado::PuedeEditar)
    crearPrivilegio(CambioEstado::PuedeEliminar)

    # causa_cambio_estados
    crearPrivilegio(CausaCambioEstado::PuedeCrear)
    crearPrivilegio(CausaCambioEstado::PuedeConsultar)
    crearPrivilegio(CausaCambioEstado::PuedeEditar)
    crearPrivilegio(CausaCambioEstado::PuedeEliminar)

    # relaciona_con_normas
    crearPrivilegio(RelacionaConNorma::PuedeCrear)
    crearPrivilegio(RelacionaConNorma::PuedeConsultar)
    crearPrivilegio(RelacionaConNorma::PuedeEditar)
    crearPrivilegio(RelacionaConNorma::PuedeEliminar)

    # tipo_relacions
    crearPrivilegio(TipoRelacion::PuedeCrear)
    crearPrivilegio(TipoRelacion::PuedeConsultar)
    crearPrivilegio(TipoRelacion::PuedeEditar)
    crearPrivilegio(TipoRelacion::PuedeEliminar)    
  end

  def change
  end

  protected
  def self.crearPrivilegio(nombre)
    Privilegio.create(:nombre => nombre)
  end
end
