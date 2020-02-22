class CreatePoseeDescriptors < ActiveRecord::Migration
  def self.up
    create_table :posee_descriptors do |t|
      t.references :norma
      t.references :descriptor_general

      t.timestamps
    end
  end

  def self.down
    drop_table :posee_descriptors
  end
end
