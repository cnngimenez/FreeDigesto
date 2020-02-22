class CambioEstado < ApplicationRecord
  belongs_to :norma
  belongs_to :causa_cambio_estado
  belongs_to :estado
end
