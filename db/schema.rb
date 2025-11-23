# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_11_23_165445) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "asignaciones", force: :cascade do |t|
    t.datetime "actualizado_en"
    t.datetime "creado_en"
    t.datetime "created_at", null: false
    t.bigint "empleado_id", null: false
    t.string "estado"
    t.bigint "evento_id", null: false
    t.string "rol"
    t.integer "servicio_id"
    t.string "tarea"
    t.datetime "updated_at", null: false
    t.index ["empleado_id"], name: "index_asignaciones_on_empleado_id"
    t.index ["evento_id"], name: "index_asignaciones_on_evento_id"
  end

  create_table "cargos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "nombre"
    t.decimal "salario"
    t.datetime "updated_at", null: false
  end

  create_table "clientes", force: :cascade do |t|
    t.datetime "actualizado_en"
    t.datetime "creado_en"
    t.datetime "created_at", null: false
    t.string "direccion"
    t.string "email"
    t.string "nombre"
    t.string "telefono"
    t.string "tipo"
    t.datetime "updated_at", null: false
  end

  create_table "contratos", force: :cascade do |t|
    t.datetime "actualizado_en"
    t.datetime "creado_en"
    t.datetime "created_at", null: false
    t.string "estado"
    t.bigint "evento_id", null: false
    t.datetime "fecha_contrato"
    t.decimal "monto_total", precision: 12, scale: 2
    t.string "numero_contrato"
    t.datetime "updated_at", null: false
    t.index ["evento_id"], name: "index_contratos_on_evento_id"
  end

  create_table "detalle_contratos", force: :cascade do |t|
    t.datetime "actualizado_en"
    t.integer "cantidad"
    t.bigint "contrato_id", null: false
    t.datetime "creado_en"
    t.datetime "created_at", null: false
    t.string "notas"
    t.decimal "precio_unitario", precision: 12, scale: 2
    t.bigint "servicio_id", null: false
    t.decimal "subtotal", precision: 12, scale: 2
    t.datetime "updated_at", null: false
    t.index ["contrato_id"], name: "index_detalle_contratos_on_contrato_id"
    t.index ["servicio_id"], name: "index_detalle_contratos_on_servicio_id"
  end

  create_table "empleados", force: :cascade do |t|
    t.boolean "activo", default: true
    t.datetime "actualizado_en"
    t.bigint "cargo_id", null: false
    t.string "categoria"
    t.datetime "creado_en"
    t.datetime "created_at", null: false
    t.string "email"
    t.datetime "fecha_contratacion"
    t.string "nombre", null: false
    t.decimal "salario", precision: 12, scale: 2, default: "0.0"
    t.string "telefono"
    t.datetime "updated_at", null: false
    t.index ["cargo_id"], name: "index_empleados_on_cargo_id"
  end

  create_table "evento_servicios", force: :cascade do |t|
    t.integer "cantidad"
    t.datetime "created_at", null: false
    t.bigint "evento_id", null: false
    t.string "notas"
    t.bigint "servicio_id", null: false
    t.datetime "updated_at", null: false
    t.index ["evento_id"], name: "index_evento_servicios_on_evento_id"
    t.index ["servicio_id"], name: "index_evento_servicios_on_servicio_id"
  end

  create_table "eventos", force: :cascade do |t|
    t.datetime "actualizado_en"
    t.bigint "cliente_id", null: false
    t.datetime "creado_en"
    t.datetime "created_at", null: false
    t.string "estado"
    t.datetime "fecha_fin"
    t.datetime "fecha_inicio"
    t.string "lugar"
    t.string "nombre_evento"
    t.string "tipo_evento"
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_eventos_on_cliente_id"
  end

  create_table "servicios", force: :cascade do |t|
    t.boolean "activo"
    t.datetime "actualizado_en"
    t.string "categoria"
    t.decimal "costo_base", precision: 12, scale: 2
    t.datetime "creado_en"
    t.datetime "created_at", null: false
    t.string "descripcion"
    t.string "nombre"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "asignaciones", "empleados"
  add_foreign_key "asignaciones", "eventos"
  add_foreign_key "contratos", "eventos"
  add_foreign_key "detalle_contratos", "contratos"
  add_foreign_key "detalle_contratos", "servicios"
  add_foreign_key "empleados", "cargos"
  add_foreign_key "evento_servicios", "eventos"
  add_foreign_key "evento_servicios", "servicios"
  add_foreign_key "eventos", "clientes"
end
