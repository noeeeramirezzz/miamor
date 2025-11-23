class CreateDetalleContratos < ActiveRecord::Migration[8.1]
  def change
    create_table :detalle_contratos do |t|
      t.references :contrato, null: false, foreign_key: true
      t.references :servicio, null: false, foreign_key: true
      t.integer :cantidad
      t.decimal :precio_unitario, precision: 12, scale: 2
      t.decimal :subtotal, precision: 12, scale: 2
      t.string :notas
      t.datetime :creado_en
      t.datetime :actualizado_en

      t.timestamps
    end
  end
end
