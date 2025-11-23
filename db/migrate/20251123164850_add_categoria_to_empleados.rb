class AddCategoriaToEmpleados < ActiveRecord::Migration[8.1]
  def change
    add_column :empleados, :categoria, :string
  end
end
