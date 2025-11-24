class AsignacionDetalle < ApplicationRecord
  self.table_name = "asignacion_detalles"

  belongs_to :asignacion
  belongs_to :servicio
  belongs_to :empleado

  # 🔥 Cuando se crea una asignación → empleado queda inactivo
  after_create :marcar_empleado_inactivo

  # 🔥 Cuando se elimina una asignación → empleado vuelve activo
  after_destroy :marcar_empleado_activo

  private

  def marcar_empleado_inactivo
    return if empleado.nil?
    empleado.update(activo: false)
  end

  def marcar_empleado_activo
    return if empleado.nil?

    # Si el empleado sigue asignado en otras filas, no se reactiva todavía
    if empleado.asignacion_detalles.where.not(id: id).exists?
      return
    end

    empleado.update(activo: true)
  end
end
