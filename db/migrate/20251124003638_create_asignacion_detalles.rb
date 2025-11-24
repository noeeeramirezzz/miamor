class CreateAsignacionDetalles < ActiveRecord::Migration[8.1]
  def change
    create_table :asignacion_detalles do |t|
      t.references :asignacion, null: false, foreign_key: { to_table: :asignaciones }
      t.references :servicio, null: false, foreign_key: true
      t.references :empleado, null: false, foreign_key: true

      t.string :rol
      t.text :tarea
      t.string :estado

      t.timestamps
    end
  end
end
