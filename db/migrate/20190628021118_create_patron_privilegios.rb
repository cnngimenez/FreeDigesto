class CreatePatronPrivilegios < ActiveRecord::Migration
  def self.up
    create_table :patron_privilegios do |t|
      t.string :nombre
      t.text :comentario

      t.timestamps
    end
  end

  def self.down
    drop_table :patron_privilegios
  end
end
