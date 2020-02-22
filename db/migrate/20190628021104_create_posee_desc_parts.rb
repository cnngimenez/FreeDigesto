class CreatePoseeDescParts < ActiveRecord::Migration
  def self.up
    create_table :posee_desc_parts do |t|
      t.references :norma
      t.references :descriptor_particular

      t.timestamps
    end
  end

  def self.down
    drop_table :posee_desc_parts
  end
end
