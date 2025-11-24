class Contrato < ApplicationRecord
  belongs_to :evento

  has_many :detalle_contratos,
           dependent: :restrict_with_error

  has_many :servicios, through: :detalle_contratos

  accepts_nested_attributes_for :detalle_contratos, allow_destroy: true

  validates :numero_contrato,
            presence: true,
            numericality: { only_integer: true, message: "solo permite números" }

  validates :fecha_contrato, presence: true
  validates :estado, presence: true

  validate :debe_tener_detalles

  # 🔥 NUEVO — cuando se guarda un contrato, si está finalizado, se reactivan empleados
  after_save :reactivar_empleados_si_finalizado

  private

  def debe_tener_detalles
    if detalle_contratos.reject(&:marked_for_destruction?).empty?
      errors.add(:base, "Debe agregar al menos un servicio al contrato.")
    end
  end

  # 🔥 NUEVO — reactiva empleados usados en asignaciones del evento
  def reactivar_empleados_si_finalizado
    return unless estado == "Finalizado"

    # obtener asignaciones del evento
    asignaciones = evento.asignaciones.includes(:asignacion_detalles)

    asignaciones.each do |asg|
      asg.asignacion_detalles.each do |detalle|
        empleado = detalle.empleado
        next unless empleado.present?

        empleado.update(activo: true)
      end
    end
  end
end

