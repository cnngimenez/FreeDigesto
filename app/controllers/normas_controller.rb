# coding: utf-8

    # normas_controller.rb
    # Copyright (C) 2010  Giménez, Christian N.

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

    # Jueves 07 De Octubre Del 2010    


class NormasController < ApplicationController
  # GET /normas/1
  # GET /normas/1.xml
  def show
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      @norma = Norma.find(params[:id])


      @estado_actual = @norma.obtener_estado_actual()
      
      # True si mostrar la opción de "mirar histórico"
      @puede_mirar_historico = verificar_privilegios(CambioEstado::PuedeConsultar)
      # True si debe mostrar las relaciones de normas
      @puede_mirar_relaciones = verificar_privilegios(RelacionaConNorma::PuedeConsultar)

      #Buscar descriptores generales de esa norma.
      @lstPoseeDesc = PoseeDescriptor.find_all_by_norma_id(params[:id])

      @lstDescriptores = []
      
      @lstPoseeDesc.each do |poseedesc|
        @lstDescriptores.push DescriptorGeneral.find(poseedesc.descriptor_general_id)
      end

      #Buscar descriptores particulares.
      @lstPoseeDesc = PoseeDescPart.find_all_by_norma_id(params[:id])

      @lstDescParts = []

      @lstPoseeDesc.each do |poseedesc|
        @lstDescParts.push DescriptorParticular.find(poseedesc.descriptor_particular_id)
      end

      # Si puede modificar o agregar elementos de la norma
      @puede_editar = verificar_privilegios(Norma::PuedeEditar)
      @puede_agregar_editar = (
        verificar_privilegios(Norma::PuedeCrear) or
        @puede_editar)
      @comentario_vacio = (
        @norma.comentarios.nil? or
        @norma.comentarios.strip() == "")
      @citas_juris_vacias = (
        @norma.citas_jurisprudenciales.nil? or
        @norma.citas_jurisprudenciales.strip() == "")
      @citas_doctorales_vacias = (
        @norma.citas_doctorales.nil? or
        @norma.citas_doctorales.strip() == "")
      @texto_vacio = (
        @norma.texto.nil? or
        @norma.texto.strip() == "")

      # Puede cambiar de estado cuando
      @puede_cambiar_estado = verificar_privilegios(CambioEstado::PuedeConsultar)

      @puede_borrar = verificar_privilegios(Norma::PuedeEliminar)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @norma }
      end
    end
  end

  # GET /normas/new
  # GET /normas/new.xml
  def new
    if not verificar_privilegios(Norma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      @norma = Norma.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @norma }
      end
    end
  end

  # GET /normas/1/edit
  def edit
    if not verificar_privilegios(Norma::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      @norma = Norma.find(params[:id])
    end
  end

  # POST /normas
  # POST /normas.xml
  def create
    if not verificar_privilegios(Norma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      @norma = Norma.new(params[:norma])

      respond_to do |format|
        if @norma.save
          flash[:notice] = 'La norma ha sido creada correctamente.'
          format.html { redirect_to(@norma) }
          format.xml  { render :xml => @norma, :status => :created, :location => @norma }
        else
          flash[:notice] = '¡Surgió un error al crear la norma!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @norma.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /normas/1
  # PUT /normas/1.xml
  def update
    if not verificar_privilegios(Norma::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      @norma = Norma.find(params[:id])

      respond_to do |format|
        if @norma.update_attributes(params[:norma])
          flash[:notice] = 'La norma ha sido actualizada correctamente.'
          format.html { redirect_to(@norma) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar la norma!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @norma.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /normas/1
  # DELETE /normas/1.xml
  def destroy
    if not verificar_privilegios("Eliminar Normas")
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      norma_id = params[:id]
      Norma.eliminar_norma(norma_id)

      flash[:notice] = "¡La norma ha sido borrada!<br />
Se recomienda que verifique la base de datos si es necesario.<br />
      <b>Id. de la norma: #{norma_id}.</b>"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml  { head :ok }
      end
    end
  end

  def historico_estados
    
  end

  # Devuelve verdadero si el usuario actual tiene permiso para
  # realizar tareas para la acción "acción"
  # Caso de que el usuario actual no tenga el permiso tal, devolverá falso.
  #def verificar_privilegios(accion)
    
  #end


  def vista_impresion_a
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      @norma = Norma.find(params[:id])


      @estado_actual = @norma.obtener_estado_actual()

      # True si mostrar la opción de "mirar histórico"
      @puede_mirar_historico = verificar_privilegios(CambioEstado::PuedeConsultar)
      # True si debe mostrar las relaciones de normas
      @puede_mirar_relaciones = verificar_privilegios(RelacionaConNorma::PuedeConsultar)

      #Buscar descriptores generales de esa norma.
      @lstPoseeDesc = PoseeDescriptor.find_all_by_norma_id(params[:id])

      @lstDescriptores = []

      @lstPoseeDesc.each do |poseedesc|
        @lstDescriptores.push DescriptorGeneral.find(poseedesc.descriptor_general_id)
      end

      #Buscar descriptores particulares.
      @lstPoseeDesc = PoseeDescPart.find_all_by_norma_id(params[:id])

      @lstDescParts = []

      @lstPoseeDesc.each do |poseedesc|
        @lstDescParts.push DescriptorParticular.find(poseedesc.descriptor_particular_id)
      end

      if (params[:tamano].nil? or 
          params[:tamano].empty?)

        # No está el parámetro tamano... buscamos el del formulario
        if (params[:vista_imp].nil? or
            params[:vista_imp][:tamano].empty?)
          # Tampoco el del formulario! usar 8 por defecto...
          @tamano = 12
        else
          # Sí está el del formulario
          @tamano = params[:vista_imp][:tamano].to_f()
        end

      else
        # Sí está el parámetro tamano...
        @tamano = params[:tamano].to_f()
      end

      # Remover todos los "size=..." que existan para dejar el tamaño al usuario.
      @norma.texto = @norma.texto.gsub(/size=[^>]*>/, ">")
      @norma.texto = @norma.texto.gsub(/font-size:[^"';]*/,"")

      respond_to do |format|
        format.html { render :layout => "norma_imprimir" }# show.html.erb
        format.xml  { render :xml => @norma }
      end
    end
  end

  def vista_impresion_b
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      @norma = Norma.find(params[:id])

      if (params[:tamano].nil? or 
          params[:tamano].empty?)

        # No está el parámetro tamano... buscamos el del formulario
        if (params[:vista_imp].nil? or
            params[:vista_imp][:tamano].empty?)
          # Tampoco el del formulario! usar 8 por defecto...
          @tamano = 12
        else
          # Sí está el del formulario
          @tamano = params[:vista_imp][:tamano].to_f()
        end

      else
        # Sí está el parámetro tamano...
        @tamano = params[:tamano].to_f()
      end

      # Remover todos los "size=..." que existan para dejar el tamaño al usuario.
      @norma.texto = @norma.texto.gsub(/size=[^>]*>/, ">")
      @norma.texto = @norma.texto.gsub(/font-size:[^"';]*/,"")

      respond_to do |format|
        format.html { render :layout => "norma_imprimir" }# show.html.erb
        format.xml  { render :xml => @norma }
      end
    end
  end

  def amigable_impresion
    if not verificar_privilegios(Norma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      #Si tiene derechos.
      @norma = Norma.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @norma }
      end
    end
  end
end
