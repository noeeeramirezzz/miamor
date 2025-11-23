class CreateContratos < ActiveRecord::Migration[8.1]
  def change
    create_table :contratos do |t|
      t.references :evento, null: false, foreign_key: true
      t.string :numero_contrato
      t.datetime :fecha_contrato
      t.decimal :monto_total, precision: 12, scale: 2
      t.string :estado
      t.datetime :creado_en
      t.datetime :actualizado_en

      t.timestamps
    end
  end
end
