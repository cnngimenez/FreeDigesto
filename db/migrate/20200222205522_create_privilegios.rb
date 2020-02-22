class CreatePrivilegios < ActiveRecord::Migration[5.2]
  def change
    create_table :privilegios do |t|
      t.string :nombre
      t.text :comentario

      t.timestamps
    end
  end
end
