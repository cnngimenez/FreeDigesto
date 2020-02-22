class CreateDescriptorGenerals < ActiveRecord::Migration
  def self.up
    create_table :descriptor_generals do |t|
      t.string :nombre
      t.text :comentario

      t.timestamps
    end
  end

  def self.down
    drop_table :descriptor_generals
  end
end
