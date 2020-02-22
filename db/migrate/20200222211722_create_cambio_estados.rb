class CreateCambioEstados < ActiveRecord::Migration[5.2]
  def change
    create_table :cambio_estados do |t|
      t.date :fecha_cambio
      t.references :norma, foreign_key: true
      t.text :comentario
      t.date :fecha_creacion
      t.references :causa_cambio_estado, foreign_key: true
      t.references :estado, foreign_key: true

      t.timestamps
    end
  end
end
