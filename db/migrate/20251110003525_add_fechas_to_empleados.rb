class AddFechasToEmpleados < ActiveRecord::Migration[8.1]
  def change
    add_column :empleados, :creado_en, :datetime
    add_column :empleados, :actualizado_en, :datetime
  end
end
