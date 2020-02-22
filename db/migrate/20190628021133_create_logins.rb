class CreateLogins < ActiveRecord::Migration
  def self.up
    create_table :logins do |t|
      t.string :nombre_usuario
      t.string :clave

      t.timestamps
    end
  end

  def self.down
    drop_table :logins
  end
end
