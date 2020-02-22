class Norma < ApplicationRecord
  belongs_to :tipo_norma
  belongs_to :estado
  belongs_to :lugar_publicacion
end
