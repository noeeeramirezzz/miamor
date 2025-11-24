class AddCierreToContratos < ActiveRecord::Migration[8.1]
  def change
    add_column :contratos, :satisfaccion_cliente, :string
    add_column :contratos, :observaciones_finales, :text
  end
end
