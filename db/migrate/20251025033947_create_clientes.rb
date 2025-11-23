class CreateClientes < ActiveRecord::Migration[8.1]
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :tipo
      t.string :telefono
      t.string :email
      t.string :direccion
      t.datetime :creado_en
      t.datetime :actualizado_en

      t.timestamps
    end
  end
end
