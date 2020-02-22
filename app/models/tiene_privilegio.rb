class TienePrivilegio < ApplicationRecord
  belongs_to :usuario
  belongs_to :privilegio
end
