class CreateCambioAplicados < ActiveRecord::Migration[5.2]
  def change
    create_table :cambio_aplicados do |t|
      t.datetime :fecha_aplicado
      t.references :cambio_estado, foreign_key: true
      t.text :comentario

      t.timestamps
    end
  end
end
