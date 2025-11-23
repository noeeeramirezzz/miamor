class Asignacion < ApplicationRecord
  self.table_name = "asignaciones"   # Esto le dice a Rails la tabla correcta
  belongs_to :servicio
  belongs_to :evento
  belongs_to :empleado
end

