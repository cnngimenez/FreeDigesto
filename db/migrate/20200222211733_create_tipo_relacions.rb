class CreateTipoRelacions < ActiveRecord::Migration[5.2]
  def change
    create_table :tipo_relacions do |t|
      t.string :nombre
      t.text :comentario

      t.timestamps
    end
  end
end
