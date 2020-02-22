class CreateNormas < ActiveRecord::Migration[5.2]
  def change
    create_table :normas do |t|
      t.string :numero
      t.text :comentarios
      t.string :sumario
      t.text :citas_doctorales
      t.text :citas_jurisprudenciales
      t.boolean :general
      t.text :texto
      t.date :fecha_publicacion
      t.date :fecha_sancion
      t.date :fecha_promulgacion
      t.references :tipo_norma, foreign_key: true
      t.references :estado, foreign_key: true
      t.references :lugar_publicacion, foreign_key: true

      t.timestamps
    end
  end
end
