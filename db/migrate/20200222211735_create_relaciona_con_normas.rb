class CreateRelacionaConNormas < ActiveRecord::Migration[5.2]
  def change
    create_table :relaciona_con_normas do |t|
      t.references :norma_a, foreign_key: true
      t.references :norma_b, foreign_key: true
      t.references :tipo_relacion, foreign_key: true

      t.timestamps
    end
  end
end
