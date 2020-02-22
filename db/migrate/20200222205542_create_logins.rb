class CreateLogins < ActiveRecord::Migration[5.2]
  def change
    create_table :logins do |t|
      t.string :nombre_usuario
      t.string :clave

      t.timestamps
    end
  end
end
