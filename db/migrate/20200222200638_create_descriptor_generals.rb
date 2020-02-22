class CreateDescriptorGenerals < ActiveRecord::Migration[5.2]
  def change
    create_table :descriptor_generals do |t|
      t.string :nombre
      t.text :comentario

      t.timestamps
    end
  end
end
