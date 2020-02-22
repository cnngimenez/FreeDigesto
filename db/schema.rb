# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "agregar_privilegios", :force => true do |t|
    t.integer  "privilegio_id"
    t.integer  "patron_privilegio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cambio_aplicados", :force => true do |t|
    t.datetime "fecha_aplicado"
    t.integer  "cambio_estado_id"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cambio_estados", :force => true do |t|
    t.date     "fecha_cambio"
    t.integer  "norma_id"
    t.text     "comentario"
    t.date     "fecha_creacion"
    t.integer  "causa_cambio_estado_id"
    t.integer  "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "causa_cambio_estados", :force => true do |t|
    t.string   "nombre"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "descriptor_generals", :force => true do |t|
    t.string   "nombre"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "descriptor_particulars", :force => true do |t|
    t.string   "nombre"
    t.integer  "descriptor_general_id"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estados", :force => true do |t|
    t.string   "nombre"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logins", :force => true do |t|
    t.string   "nombre_usuario"
    t.string   "clave"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lugar_publicacions", :force => true do |t|
    t.string   "nombre"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "normas", :force => true do |t|
    t.string   "numero"
    t.integer  "tipo_norma_id"
    t.text     "comentarios"
    t.text     "sumario"
    t.text     "citas_doctorales"
    t.text     "citas_jurisprudenciales"
    t.boolean  "general"
    t.text     "texto"
    t.date     "fecha_publicacion"
    t.date     "fecha_sancion"
    t.date     "fecha_promulgacion"
    t.integer  "lugar_publicacion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patron_privilegios", :force => true do |t|
    t.string   "nombre"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posee_desc_parts", :force => true do |t|
    t.integer  "norma_id"
    t.integer  "descriptor_particular_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posee_descriptors", :force => true do |t|
    t.integer  "norma_id"
    t.integer  "descriptor_general_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privilegios", :force => true do |t|
    t.string   "nombre"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relaciona_con_normas", :force => true do |t|
    t.integer  "norma_a_id"
    t.integer  "norma_b_id"
    t.integer  "tipo_relacion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tiene_privilegios", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "privilegio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_normas", :force => true do |t|
    t.string   "nombre"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipo_relacions", :force => true do |t|
    t.string   "nombre"
    t.text     "comentario"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "contrasena"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
