class AddSalarioToCargos < ActiveRecord::Migration[8.1]
  def change
    add_column :cargos, :salario, :decimal
  end
end
