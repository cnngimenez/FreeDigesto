class CreatePoseeDescParts < ActiveRecord::Migration[5.2]
  def change
    create_table :posee_desc_parts do |t|
      t.references :norma, foreign_key: true
      t.references :descriptor_particular, foreign_key: true

      t.timestamps
    end
  end
end
