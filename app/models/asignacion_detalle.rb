class AsignacionDetalle < ApplicationRecord
  self.table_name = "asignacion_detalles"

  belongs_to :asignacion, inverse_of: :asignacion_detalles
  belongs_to :servicio
  belongs_to :empleado, optional: true

  # Cuando se crea una asignación → empleado queda inactivo
  after_create :marcar_empleado_inactivo

  # Cuando se elimina → si ya no está en otras asignaciones, se reactiva
  after_destroy :marcar_empleado_activo

  private

  def marcar_empleado_inactivo
    return if empleado.nil?
    empleado.update(activo: false)
  end

  def marcar_empleado_activo
    return if empleado.nil?

    sigue_en_otro = empleado.asignacion_detalles.where.not(id: id).exists?
    return if sigue_en_otro

    empleado.update(activo: true)
  end
end
