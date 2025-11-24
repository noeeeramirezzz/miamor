class Asignacion < ApplicationRecord
  self.table_name = "asignaciones"

  belongs_to :evento

  # 🔥 AHORA: elimina automáticamente los detalles al borrar la asignación
  has_many :asignacion_detalles,
           dependent: :destroy,
           inverse_of: :asignacion   # Necesario para formularios nested

  # Permite crear / editar / borrar detalles desde el formulario
  accepts_nested_attributes_for :asignacion_detalles, allow_destroy: true

  # 🔥 Si cambia el estado a Finalizada → reactivar empleados
  after_update :reactivar_empleados_si_finalizado

  private

  def reactivar_empleados_si_finalizado
    return unless saved_change_to_estado?        # Solo si cambió el estado
    return unless estado == "Finalizada"         # Solo si está finalizada

    asignacion_detalles.includes(:empleado).each do |detalle|
      emp = detalle.empleado
      next if emp.nil?

      emp.update(activo: true)                   # Reactivar empleado
    end
  end
end
