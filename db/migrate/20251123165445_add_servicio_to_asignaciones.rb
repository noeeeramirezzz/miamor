class AddServicioToAsignaciones < ActiveRecord::Migration[8.1]
  def change
    add_column :asignaciones, :servicio_id, :integer
  end
end
