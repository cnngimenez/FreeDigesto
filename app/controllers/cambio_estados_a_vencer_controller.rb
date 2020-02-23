# coding: utf-8

# cambio_estados_a_vencer_controller.rb
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


class CambioEstadosAVencerController < ApplicationController
  def index
    if not verificar_privilegios(CambioEstado::PuedeConsultar)
      #No tiene derechos para ver index.
      #flash[:notice] = "¡Usted no puede consultar los cambios de estados!"
      respond_to do |format|
        #format.html { redirect_to :controller => 'pagina_principal'}
        format.html { render :html => '' }
        format.xml { head :ok}
      end
    else

      @lst_ce_a_vencer = CambioEstado.obtener_a_vencer(14)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @cambio_estados }
      end
    end
  end
end
