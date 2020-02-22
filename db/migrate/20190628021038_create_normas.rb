class CreateNormas < ActiveRecord::Migration
  def self.up
    create_table :normas do |t|
      t.string :numero
      t.references :tipo_norma
      t.text :comentarios
      t.text :sumario
      t.text :citas_doctorales
      t.text :citas_jurisprudenciales
      t.boolean :general
      t.text :texto
      t.date :fecha_publicacion
      t.date :fecha_sancion
      t.date :fecha_promulgacion
      t.references :lugar_publicacion

      t.timestamps
    end
  end

  def self.down
    drop_table :normas
  end
end
