class EventoServicio < ApplicationRecord
  belongs_to :evento
  belongs_to :servicio
end
