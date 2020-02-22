
    # quitar_descriptor_controller.rb
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


class QuitarDescriptorController < ApplicationController
  def index
    if not verificar_privilegios(PoseeDescriptor::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede quitar descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      respond_to do |format|
        format.html
      end
    end
  end


  def quitar_desc_gen
    if not verificar_privilegios(PoseeDescriptor::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      # Buscar la norma
      if params[:norma].nil?
        if params[:id].nil?
          #No designó una norma
          flash[:notice] = "¡Debe indicar una norma!"
          redirect_to :action => "index"
          return
        else  
          @norma = Norma.find(params[:id])
        end
      else
        @norma = Norma.buscar_por_num_ids(params[:norma][:numero], params[:norma][:tipo])
      end

      #Buscar los descriptores generales adecuados
      @lst_desc_gens = PoseeDescriptor.find_all_by_norma_id(@norma)
      

      #Buscar los descriptores particulares adecuados
      # Buscamos todos los particulares de los generales que posee
      # y luego filtramos por los que posee esta norma.

      @lst_desc_parts = Array.new

      #Buscamos todos los de la norma
      

      @lst_desc_gens.each do |posee_dg|
        dg = posee_dg.descriptor_general
        lst_aux = PoseeDescPart.buscar_por_dg_norma(@norma.id, dg.id)        
        @lst_desc_parts.push([dg,lst_aux])
      end      

      respond_to do |format|
        format.html
      end
    end
  end

  def quitar_desc_part
    if not verificar_privilegios(PoseeDescPart::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      if params[:descriptor].nil?
        redirect_to :action => "quitar_desc_gen", :id => params[:id]
      end      
      lst_posee_desc_part_ids = params[:descriptor][:id].scan(/\d+ /)      

      error = ""
      lst_posee_desc_part_ids.each do |dp_id|
        pdp = PoseeDescPart.find(dp_id.to_i)
        unless pdp.destroy
          error = error + pdp.id + " "
        end
      end

      if error == ""
        flash[:notice] = "Se han quitado exitósamente."
      else
        flash[:notice] = "¡Hubo problemas al quitar los \"posee_descriptor\": " + error
      end

      redirect_to :action => "quitar_desc_gen", :id => params[:id]
    end
  end

  # Borra una relación entre norma y descriptor general(posee_descriptor) y todas las relaciones de
  # sus descriptores particulares con esta norma(posee_desc_parts)
  #
  def eliminar_posee_desc
    if not verificar_privilegios(PoseeDescriptor::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede agregar descriptores generales!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      # Buscar los posee_desc_parts que posee la norma.
      posee_descriptor = PoseeDescriptor.find(params[:posee_desc_gen_id])
      lst_posee_desc_parts = PoseeDescPart.buscar_por_dg_norma(
        params[:norma_id], posee_descriptor.descriptor_general.id)


      # Eliminamos los posee descriptores particulares uno a uno
      error = ""      
      lst_posee_desc_parts.each do |pdp|
        pdp_id = pdp.id
        dp = pdp.descriptor_particular

        unless pdp.destroy
          error = error + " posee descriptor particular id: " + pdp_id.to_s +
            " descriptor particular en relación: " + dp.nombre + " | "
        end
      end

      if error == ""
        flash[:notice] = "Se han quitado exitósamente"
      else
        flash[:notice] = "Hubo problemas al quitar: " + error
      end

      # Eliminamos el descriptor general      
      posee_descriptor.destroy

      redirect_to :action => "quitar_desc_gen", :id => params[:norma_id]
    end
  end
end
