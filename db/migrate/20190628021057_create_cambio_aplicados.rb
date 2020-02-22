class CreateCambioAplicados < ActiveRecord::Migration
  def self.up
    create_table :cambio_aplicados do |t|
      t.datetime :fecha_aplicado
      t.references :cambio_estado
      t.text :comentario

      t.timestamps
    end
  end

  def self.down
    drop_table :cambio_aplicados
  end
end
