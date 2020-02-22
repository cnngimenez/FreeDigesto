class CreateCausaCambioEstados < ActiveRecord::Migration
  def self.up
    create_table :causa_cambio_estados do |t|
      t.string :nombre
      t.text :comentario

      t.timestamps
    end
  end

  def self.down
    drop_table :causa_cambio_estados
  end
end
