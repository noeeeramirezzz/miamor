class Asignacion < ApplicationRecord
  self.table_name = "asignaciones"
  belongs_to :evento

  has_many :asignacion_detalles, dependent: :destroy
  accepts_nested_attributes_for :asignacion_detalles, allow_destroy: true

  # 🔥 Cuando cambia el estado, verificamos si se finalizó
  after_update :reactivar_empleados_si_finalizado

  private

  def reactivar_empleados_si_finalizado
    return unless saved_change_to_estado?        # Solo si cambió el estado
    return unless estado == "Finalizada"         # Solo si está finalizada

    # Traer empleados que participaron en esta asignación
    asignacion_detalles.includes(:empleado).each do |detalle|
      emp = detalle.empleado
      next if emp.nil?

      emp.update(activo: true)                   # 🔥 Reactivar empleado
    end
  end
end
