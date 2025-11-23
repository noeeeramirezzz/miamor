class CreateEventos < ActiveRecord::Migration[8.1]
  def change
    create_table :eventos do |t|
      t.references :cliente, null: false, foreign_key: true
      t.string :nombre_evento
      t.string :tipo_evento
      t.datetime :fecha_inicio
      t.datetime :fecha_fin
      t.string :lugar
      t.string :estado
      t.datetime :creado_en
      t.datetime :actualizado_en

      t.timestamps
    end
  end
end
