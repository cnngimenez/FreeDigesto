class CreatePoseeDescriptors < ActiveRecord::Migration[5.2]
  def change
    create_table :posee_descriptors do |t|
      t.references :norma, foreign_key: true
      t.references :descriptor_general, foreign_key: true

      t.timestamps
    end
  end
end
