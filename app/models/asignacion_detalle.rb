class AsignacionDetalle < ApplicationRecord
  self.table_name = "asignacion_detalles"

  belongs_to :asignacion
  belongs_to :servicio
  belongs_to :empleado
end
