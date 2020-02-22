class CreateTienePrivilegios < ActiveRecord::Migration
  def self.up
    create_table :tiene_privilegios do |t|
      t.references :usuario
      t.references :privilegio

      t.timestamps
    end
  end

  def self.down
    drop_table :tiene_privilegios
  end
end
