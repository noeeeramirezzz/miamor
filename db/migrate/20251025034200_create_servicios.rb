class CreateServicios < ActiveRecord::Migration[8.1]
  def change
    create_table :servicios do |t|
      t.string :nombre
      t.string :categoria
      t.string :descripcion
      t.decimal :costo_base, precision: 12, scale: 2
      t.boolean :activo
      t.datetime :creado_en
      t.datetime :actualizado_en

      t.timestamps
    end
  end
end
