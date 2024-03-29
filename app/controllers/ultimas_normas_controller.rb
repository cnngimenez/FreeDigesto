# coding: utf-8

# ultimas_normas_controller.rb
# Copyright (C) 2011  Giménez, Christian N.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Martes 19 De Abril Del 2011    

class UltimasNormasController < ApplicationController

  # El index acepta como parámetro (de POST o GET) la cantidad
  # de normas a listar(del la más nueva a la más antigua).
  def index
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      if (params[:cant].nil? or params[:cant] == '')
        @cant = 10
      else
        @cant = params[:cant]
      end
      
      @lstnormas = Norma.all.order(id: :desc).limit(@cant)

      respond_to do |format|
        format.html
      end
    end
  end
end
