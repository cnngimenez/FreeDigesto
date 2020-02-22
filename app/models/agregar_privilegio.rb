class AgregarPrivilegio < ApplicationRecord
  belongs_to :Privilegio
  belongs_to :Patron_privilegio
end
