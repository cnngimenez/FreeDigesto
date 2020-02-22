class CreatePrivilegios < ActiveRecord::Migration
  def self.up
    create_table :privilegios do |t|
      t.string :nombre
      t.text :comentario

      t.timestamps
    end
  end

  def self.down
    drop_table :privilegios
  end
end
