class RemoveCamposInvalidosFromAsignaciones < ActiveRecord::Migration[8.1]
  def change
    remove_column :asignaciones, :empleado_id, :integer
    remove_column :asignaciones, :rol, :string
    remove_column :asignaciones, :tarea, :string
  end
end
