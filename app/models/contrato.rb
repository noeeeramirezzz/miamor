class Contrato < ApplicationRecord
  belongs_to :evento

  has_many :detalle_contratos, dependent: :destroy
  has_many :servicios, through: :detalle_contratos

  accepts_nested_attributes_for :detalle_contratos, allow_destroy: true
end
class Contrato < ApplicationRecord
  belongs_to :evento
  has_many :detalle_contratos, dependent: :destroy

  accepts_nested_attributes_for :detalle_contratos, allow_destroy: true

  # VALIDACIONES
  validates :numero_contrato,
            presence: true,
            numericality: { only_integer: true, message: "solo permite números" }

  validates :fecha_contrato, presence: true
  validates :estado, presence: true

  validate :debe_tener_detalles

  private


  def debe_tener_detalles
    if detalle_contratos.reject(&:marked_for_destruction?).empty?
      errors.add(:base, "Debe agregar al menos un servicio al contrato.")
    end
  end
end

