class CreateTipoNormas < ActiveRecord::Migration
  def self.up
    create_table :tipo_normas do |t|
      t.string :nombre
      t.text :comentario

      t.timestamps
    end
  end

  def self.down
    drop_table :tipo_normas
  end
end
