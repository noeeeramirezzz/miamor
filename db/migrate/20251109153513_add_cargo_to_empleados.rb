class AddCargoToEmpleados < ActiveRecord::Migration[8.1]
  def up
    # 1️⃣ Crear la columna permitiendo NULL temporalmente
    add_reference :empleados, :cargo, null: true, foreign_key: true

    # 2️⃣ Asignar un cargo por defecto a empleados ya existentes
    say_with_time "Asignando cargo por defecto a empleados existentes" do
      cargo_default = Cargo.first || Cargo.create!(nombre: "Sin asignar", salario: 0)
      Empleado.where(cargo_id: nil).update_all(cargo_id: cargo_default.id)
    end

    # 3️⃣ Convertir la columna a NOT NULL después del backfill
    change_column_null :empleados, :cargo_id, false
  end

  def down
    remove_reference :empleados, :cargo, foreign_key: true
  end
end
