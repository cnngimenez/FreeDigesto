
    # modificar_norma_controller.rb
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


class ModificarNormaController < ApplicationController
  def index
    @puede_editar = verificar_privilegios(Norma::PuedeEditar)

    if not (@puede_editar or verificar_privilegios(Norma::PuedeCrear))
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede modificar normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        format.xml { head :ok}
      end
    else
      
      respond_to do |format|
        format.html
      end
    end
  end

  def buscar_norma
    @puede_editar = verificar_privilegios(Norma::PuedeEditar)

    if not (@puede_editar or verificar_privilegios(Norma::PuedeCrear))
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede modificar normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        format.xml { head :ok}
      end
    else

      @norma = Norma.buscar_por_num_ids(
        params[:buscar_norma][:numero],
        params[:buscar_norma][:tipo])

      if @norma.nil?
        # ¡No se encontró esa norma! Volver atrás.
        flash[:notice] = "¡No se encontró esa norma!"
        respond_to do |format|
          format.html {redirect_to :action => "index"}
        end
        return
      end

      respond_to do |format|
        format.html{ redirect_to :action => "modificar_norma", :id => @norma}
      end
    end
  end


  def modificar_norma
    @puede_editar = verificar_privilegios(Norma::PuedeEditar)

    if not (@puede_editar or verificar_privilegios(Norma::PuedeCrear))
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede modificar normas!"
      respond_to do |format|
        format.html { redirect_to :controller => "pagina_principal"}
        format.xml { head :ok}
      end
    else
      @norma = Norma.find(params[:id])

      @citas_vacias = (
        @norma.citas_jurisprudenciales.nil? or
        @norma.citas_jurisprudenciales.strip() == "" or
        @norma.citas_doctorales.nil? or
        @norma.citas_doctorales.strip() == "")

      @comentarios_vacios = (
        @norma.comentarios.nil? or
        @norma.comentarios.strip() == "")

      @texto_vacio = (
        @norma.texto.nil? or
        @norma.texto.strip() == "")
      
      respond_to do |format|
        format.html
      end
    end
  end
end
