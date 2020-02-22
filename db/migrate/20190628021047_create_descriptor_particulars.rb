class CreateDescriptorParticulars < ActiveRecord::Migration
  def self.up
    create_table :descriptor_particulars do |t|
      t.string :nombre
      t.references :descriptor_general
      t.text :comentario

      t.timestamps
    end
  end

  def self.down
    drop_table :descriptor_particulars
  end
end
