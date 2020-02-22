class CreateRelacionaConNormas < ActiveRecord::Migration
  def self.up
    create_table :relaciona_con_normas do |t|
      t.references :norma_a
      t.references :norma_b
      t.references :tipo_relacion

      t.timestamps
    end
  end

  def self.down
    drop_table :relaciona_con_normas
  end
end
