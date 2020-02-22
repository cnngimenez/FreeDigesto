class CreateLugarPublicacions < ActiveRecord::Migration[5.2]
  def change
    create_table :lugar_publicacions do |t|
      t.string :nombre
      t.text :comentario

      t.timestamps
    end
  end
end
