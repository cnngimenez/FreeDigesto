class CreateAgregarPrivilegios < ActiveRecord::Migration
  def self.up
    create_table :agregar_privilegios do |t|
      t.references :privilegio
      t.references :patron_privilegio

      t.timestamps
    end
  end

  def self.down
    drop_table :agregar_privilegios
  end
end
