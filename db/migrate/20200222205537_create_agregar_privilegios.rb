class CreateAgregarPrivilegios < ActiveRecord::Migration[5.2]
  def change
    create_table :agregar_privilegios do |t|
      t.references :Privilegio, foreign_key: true
      t.references :Patron_privilegio, foreign_key: true

      t.timestamps
    end
  end
end
