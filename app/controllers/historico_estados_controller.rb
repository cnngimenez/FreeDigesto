
    # historico_estados_controller.rb
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


class HistoricoEstadosController < ApplicationController

  def index
    if not verificar_privilegios(CambioEstado::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar el histórico!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      if params[:id_norma].nil?
        flash[:notice] = "¡Debe escoger una norma!"
        redirect_to :controller => 'pagina_principal'
        return
      end

      @norma = Norma.find(params[:id_norma])
      #Buscar el estado actual y los aplicados
      @lst_estados_aplicados = Norma.obtener_hash_cambios_aplicados(@norma)
      if not @lst_estados_aplicados.empty?
        @estado_actual = @lst_estados_aplicados.first().at(1).cambio_estado.estado
      else
        @estado_actual = nil
      end

      #Buscar todos los cambios de estados
      @lst_cambios_estados = Norma.obtener_cambios_estados(@norma)


      respond_to do |format|
        format.html 
        format.xml  { head :ok }
      end
    end 
  end
end
