class RelacionaConNorma < ApplicationRecord
  belongs_to :norma_a
  belongs_to :norma_b
  belongs_to :tipo_relacion
end
