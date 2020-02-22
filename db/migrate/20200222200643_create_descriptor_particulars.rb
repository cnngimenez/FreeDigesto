class CreateDescriptorParticulars < ActiveRecord::Migration[5.2]
  def change
    create_table :descriptor_particulars do |t|
      t.string :nombre
      t.text :comentario
      t.references :descriptor_general, foreign_key: true

      t.timestamps
    end
  end
end
