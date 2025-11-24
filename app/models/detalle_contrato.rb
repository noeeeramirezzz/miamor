class DetalleContrato < ApplicationRecord
  belongs_to :contrato
  belongs_to :servicio
end
class DetalleContrato < ApplicationRecord
  belongs_to :contrato
  belongs_to :servicio

  # VALIDACIONES
  validates :servicio_id, presence: true
  validates :cantidad, presence: true, numericality: { greater_than: 0 }
  validates :precio_unitario, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :subtotal, presence: true
end

