# coding: utf-8
class InsertarAgregarPrivilegiosPorDefecto < ActiveRecord::Migration[5.2]
  def self.up
    down
    # Sin privilegios no se agrega nada aquí...

    # Root tiene todos los privilegios, así que, hay que agregar todos.
    # Buscar todos los privilegios, y por cada uno
    # crear un AgregarPrivilegio con el privilegio y el patrón asignados.
    lstprivs = Privilegio.all
    patron = PatronPrivilegio.find_by nombre: "Root"
    lstprivs.each{|priv|
      ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                                 :patron_privilegio_id => patron.id)
      ap.save
    }

    # Consultor sólo tiene tres privilegios:
    # * Puede consultar normas
    # * Puede consultar descriptores
    # * Puede consultar descriptores particulares
    patron = PatronPrivilegio.find_by nombre: "Consultor"
    priv = Privilegio.find_by nombre: Norma::PuedeConsultar
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by nombre: DescriptorGeneral::PuedeConsultar
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by nombre: DescriptorParticular::PuedeConsultar
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save

    # Data entry tiene los mismos privilegios que el consultor y se agregan:
    # * Puede agregar normas
    # * Puede consultar y agregar los "cambio norma"
    patron = PatronPrivilegio.find_by nombre: "Data Entry"
    priv = Privilegio.find_by_nombre(Norma::PuedeConsultar)
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by nombre: DescriptorGeneral::PuedeConsultar
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by nombre: DescriptorParticular::PuedeConsultar
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by nombre: Norma::PuedeCrear
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by nombre: PoseeDescriptor::PuedeCrear
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by nombre: PoseeDescPart::PuedeCrear
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    
    # Privilegios para los vencimientos

    priv = Privilegio.find_by nombre: CambioEstado::PuedeConsultar
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by nombre: CambioAplicado::PuedeConsultar
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by nombre: CausaCambioEstado::PuedeConsultar
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by nombre: CambioEstado::PuedeCrear
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
    priv = Privilegio.find_by nombre: CambioAplicado::PuedeCrear
    ap = AgregarPrivilegio.new(:privilegio_id => priv.id,
                               :patron_privilegio_id => patron.id)
    ap.save
  end

  def self.down
    AgregarPrivilegio.delete_all
  end

end
