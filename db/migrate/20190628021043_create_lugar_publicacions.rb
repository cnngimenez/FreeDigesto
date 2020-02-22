class CreateLugarPublicacions < ActiveRecord::Migration
  def self.up
    create_table :lugar_publicacions do |t|
      t.string :nombre
      t.text :comentario

      t.timestamps
    end
  end

  def self.down
    drop_table :lugar_publicacions
  end
end
