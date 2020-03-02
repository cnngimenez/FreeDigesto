# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_23_011917) do

  create_table "agregar_privilegios", force: :cascade do |t|
    t.integer "privilegio_id"
    t.integer "patron_privilegio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patron_privilegio_id"], name: "index_agregar_privilegios_on_patron_privilegio_id"
    t.index ["privilegio_id"], name: "index_agregar_privilegios_on_privilegio_id"
  end

  create_table "cambio_aplicados", force: :cascade do |t|
    t.datetime "fecha_aplicado"
    t.integer "cambio_estado_id"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cambio_estado_id"], name: "index_cambio_aplicados_on_cambio_estado_id"
  end

  create_table "cambio_estados", force: :cascade do |t|
    t.date "fecha_cambio"
    t.integer "norma_id"
    t.text "comentario"
    t.date "fecha_creacion"
    t.integer "causa_cambio_estado_id"
    t.integer "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["causa_cambio_estado_id"], name: "index_cambio_estados_on_causa_cambio_estado_id"
    t.index ["estado_id"], name: "index_cambio_estados_on_estado_id"
    t.index ["norma_id"], name: "index_cambio_estados_on_norma_id"
  end

  create_table "causa_cambio_estados", force: :cascade do |t|
    t.string "nombre"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "descriptor_generals", force: :cascade do |t|
    t.string "nombre"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "descriptor_particulars", force: :cascade do |t|
    t.string "nombre"
    t.text "comentario"
    t.integer "descriptor_general_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["descriptor_general_id"], name: "index_descriptor_particulars_on_descriptor_general_id"
  end

  create_table "estados", force: :cascade do |t|
    t.string "nombre"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logins", force: :cascade do |t|
    t.string "nombre_usuario"
    t.string "clave"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lugar_publicacions", force: :cascade do |t|
    t.string "nombre"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "normas", force: :cascade do |t|
    t.string "numero"
    t.text "comentarios"
    t.string "sumario"
    t.text "citas_doctorales"
    t.text "citas_jurisprudenciales"
    t.boolean "general"
    t.text "texto"
    t.date "fecha_publicacion"
    t.date "fecha_sancion"
    t.date "fecha_promulgacion"
    t.integer "tipo_norma_id"
    t.integer "estado_id"
    t.integer "lugar_publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado_id"], name: "index_normas_on_estado_id"
    t.index ["lugar_publicacion_id"], name: "index_normas_on_lugar_publicacion_id"
    t.index ["tipo_norma_id"], name: "index_normas_on_tipo_norma_id"
  end

  create_table "patron_privilegios", force: :cascade do |t|
    t.string "nombre"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posee_desc_parts", force: :cascade do |t|
    t.integer "norma_id"
    t.integer "descriptor_particular_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["descriptor_particular_id"], name: "index_posee_desc_parts_on_descriptor_particular_id"
    t.index ["norma_id"], name: "index_posee_desc_parts_on_norma_id"
  end

  create_table "posee_descriptors", force: :cascade do |t|
    t.integer "norma_id"
    t.integer "descriptor_general_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["descriptor_general_id"], name: "index_posee_descriptors_on_descriptor_general_id"
    t.index ["norma_id"], name: "index_posee_descriptors_on_norma_id"
  end

  create_table "privilegios", force: :cascade do |t|
    t.string "nombre"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relaciona_con_normas", force: :cascade do |t|
    t.integer "norma_a_id"
    t.integer "norma_b_id"
    t.integer "tipo_relacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["norma_a_id"], name: "index_relaciona_con_normas_on_norma_a_id"
    t.index ["norma_b_id"], name: "index_relaciona_con_normas_on_norma_b_id"
    t.index ["tipo_relacion_id"], name: "index_relaciona_con_normas_on_tipo_relacion_id"
  end

  create_table "tiene_privilegios", force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "privilegio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["privilegio_id"], name: "index_tiene_privilegios_on_privilegio_id"
    t.index ["usuario_id"], name: "index_tiene_privilegios_on_usuario_id"
  end

  create_table "tipo_normas", force: :cascade do |t|
    t.string "nombre"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_relacions", force: :cascade do |t|
    t.string "nombre"
    t.text "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre"
    t.string "contrasena"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
