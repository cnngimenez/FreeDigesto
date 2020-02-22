class CreateCausaCambioEstados < ActiveRecord::Migration[5.2]
  def change
    create_table :causa_cambio_estados do |t|
      t.string :nombre
      t.text :comentario

      t.timestamps
    end
  end
end
