class AddSalarioToEmpleados < ActiveRecord::Migration[8.1]
  def change
    add_column :empleados, :salario, :decimal
  end
end
