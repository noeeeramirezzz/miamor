class AddServicioToAsignaciones < ActiveRecord::Migration[8.1]
  def change
    add_reference :asignaciones, :servicio, foreign_key: true
  end
end
