class CreateEmpleados < ActiveRecord::Migration[8.1]
  def change
    create_table :empleados do |t|
      t.string :nombre, null: false
      t.string :telefono
      t.string :email
      t.boolean :activo, default: true
      t.datetime :fecha_contratacion
      t.decimal :salario, precision: 12, scale: 2, default: 0
      t.references :cargo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
