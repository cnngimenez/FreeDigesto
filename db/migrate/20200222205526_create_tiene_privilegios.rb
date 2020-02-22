class CreateTienePrivilegios < ActiveRecord::Migration[5.2]
  def change
    create_table :tiene_privilegios do |t|
      t.references :usuario, foreign_key: true
      t.references :privilegio, foreign_key: true

      t.timestamps
    end
  end
end
