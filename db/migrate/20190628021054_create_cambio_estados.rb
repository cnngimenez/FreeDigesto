class CreateCambioEstados < ActiveRecord::Migration
  def self.up
    create_table :cambio_estados do |t|
      t.date :fecha_cambio
      t.references :norma
      t.text :comentario
      t.date :fecha_creacion
      t.references :causa_cambio_estado
      t.references :estado

      t.timestamps
    end
  end

  def self.down
    drop_table :cambio_estados
  end
end
