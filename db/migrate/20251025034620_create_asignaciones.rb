class CreateAsignaciones < ActiveRecord::Migration[8.1]

def change
    create_table :asignaciones do |t|
      t.references :evento, null: false, foreign_key: true
      t.references :empleado, null: false, foreign_key: true
      t.string :rol
      t.string :tarea
      t.string :estado
      t.datetime :creado_en
      t.datetime :actualizado_en

      t.timestamps
    end
  end
end
