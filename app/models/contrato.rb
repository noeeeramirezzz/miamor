class Contrato < ApplicationRecord
  belongs_to :evento

  # 🔥 AHORA SÍ: elimina los detalles automáticamente
  has_many :detalle_contratos,
           dependent: :destroy

  has_many :servicios, through: :detalle_contratos

  accepts_nested_attributes_for :detalle_contratos, allow_destroy: true

  # ➤ VALIDACIÓN COMPLETA DEL NÚMERO (NUEVO: uniqueness)
  validates :numero_contrato,
            presence: true,
            numericality: { only_integer: true, message: "solo permite números" },
            uniqueness: { message: "ya existe un contrato con este número" }

  validates :fecha_contrato, presence: true
  validates :estado, presence: true

  validate :debe_tener_detalles

  # ➤ Normalizar número para evitar duplicados tipo "01" vs "1"
  before_validation :normalizar_numero

  # 🔥 Cuando se guarda un contrato finalizado → empleados vuelven activos
  after_save :reactivar_empleados_si_finalizado

  private

  # 🔥 Convierte "001", "01", "0005" → 1, 1, 5
  def normalizar_numero
    self.numero_contrato = numero_contrato.to_i if numero_contrato.present?
  end

  def debe_tener_detalles
    if detalle_contratos.reject(&:marked_for_destruction?).empty?
      errors.add(:base, "Debe agregar al menos un servicio al contrato.")
    end
  end

  # 🔥 Reactivar empleados cuando el contrato se finaliza
  def reactivar_empleados_si_finalizado
    return unless estado == "Finalizado"

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
