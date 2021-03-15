# coding: utf-8

    # relaciona_con_normas_controller.rb
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


class RelacionaConNormasController < ApplicationController
  # GET /relaciona_con_normas
  # GET /relaciona_con_normas.xml
  def index
    if not verificar_privilegios(RelacionaConNorma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las relaciones de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @relaciona_con_normas = []
      @relaciones_salientes = nil
      @relaciones_entrantes = nil
      if (not params[:id_norma].nil?)
        @norma = Norma.find(params[:id_norma])
        @relaciones_salientes = RelacionaConNorma.buscar_relaciones_salientes(@norma)
        @relaciones_entrantes = RelacionaConNorma.buscar_relaciones_entrantes(@norma)
        #else
        ## No se debería poder buscar toooodaas las relaciones de normas...
        ## esto evitaría saturar al servidor.
        #  @relaciona_con_normas = RelacionaConNorma.find(:all)
      elsif (not params[:filtrar].nil?)
        @norma = Norma.buscar_por_num_ids(
                                          params[:filtrar][:numero],
                                          params[:filtrar][:tipo_norma])
        @relaciones_salientes = RelacionaConNorma.buscar_relaciones_salientes(@norma)
        @relaciones_entrantes = RelacionaConNorma.buscar_relaciones_entrantes(@norma)
      end

      @puede_crear = verificar_privilegios(RelacionaConNorma::PuedeCrear)

      if params[:vista_impresion].nil?
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @relaciona_con_normas }
        end
      else
        respond_to do |format|
          format.html { render :action => 'vista_impresion', :layout => 'relaciona_con_normas_imprimir'}
        end
      end
    end
  end

  # GET /relaciona_con_normas/1
  # GET /relaciona_con_normas/1.xml
  def show
    if not verificar_privilegios(RelacionaConNorma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las relaciones de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @relaciona_con_norma = RelacionaConNorma.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @relaciona_con_norma }
      end
    end
  end

  # GET /relaciona_con_normas/new
  # GET /relaciona_con_normas/new.xml
  def new
    if not verificar_privilegios(RelacionaConNorma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear relaciones de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      if (params[:id_norma].nil?)
        @norma_inicial = nil
      else
        @norma_inicial = Norma.find(params[:id_norma])
      end

      @relaciona_con_norma = RelacionaConNorma.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @relaciona_con_norma }
      end
    end
  end

  # GET /relaciona_con_normas/1/edit
  def edit
    if not verificar_privilegios(RelacionaConNorma::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar las relaciones de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @relaciona_con_norma = RelacionaConNorma.find(params[:id])
    end
  end

  # POST /relaciona_con_normas
  # POST /relaciona_con_normas.xml
  def create
    if not verificar_privilegios(RelacionaConNorma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear las relaciones de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @relaciona_con_norma = RelacionaConNorma.new(params[:relaciona_con_norma])
      if (params[:id_norma].nil?)
        # No hubo una norma inicial, el usuario seleccionó una usando el número
        # y el tipo de norma.
        @relaciona_con_norma.norma_a = Norma.buscar_por_num_ids(
          params[:relacion][:normaA_num],
          params[:relacion][:tipo_normaA])
      else
        # Sí hubo una norma inicial.
        @norma_inicial = Norma.find(params[:id_norma])
        @relaciona_con_norma.norma_a = @norma_inicial
      end

      @relaciona_con_norma.norma_b = Norma.buscar_por_num_ids(
        params[:relacion][:normaB_num],
        params[:relacion][:tipo_normaB])

      #@relaciona_con_norma.tipo_relacion = TipoRelacion.find(params[:relacion][:tipo_relacion])

      respond_to do |format|
        if @relaciona_con_norma.save
          flash[:notice] = 'Se ha relacionado las normas correctamente.'

          format.html { redirect_to(@relaciona_con_norma) }
          format.xml  { render :xml => @relaciona_con_norma, :status => :created, :location => @relaciona_con_norma }
        else
          flash[:notice] = '¡Surgió un error al relacionar las normas!'
          format.html { render :action => "new", :id_norma => params[:id_norma] }
          format.xml  { render :xml => @relaciona_con_norma.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /relaciona_con_normas/1
  # PUT /relaciona_con_normas/1.xml
  def update
    if not verificar_privilegios(RelacionaConNorma::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar las relaciones de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @relaciona_con_norma = RelacionaConNorma.find(params[:id])

      respond_to do |format|
        if @relaciona_con_norma.update_attributes(params[:relaciona_con_norma])
          flash[:notice] = 'Se ha actualizado la relación correctamente.'
          format.html { redirect_to(@relaciona_con_norma) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar la relación!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @relaciona_con_norma.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /relaciona_con_normas/1
  # DELETE /relaciona_con_normas/1.xml
  def destroy
    if not verificar_privilegios(RelacionaConNorma::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar las relaciones de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @relaciona_con_norma = RelacionaConNorma.find(params[:id])
      @relaciona_con_norma.destroy

      respond_to do |format|
        format.html { redirect_to(relaciona_con_normas_url) }
        format.xml  { head :ok }
      end
    end
  end

  # Muestra la relación en un formato amigable a la impresión.
  #
  def vista_impresion
    if not verificar_privilegios(RelacionaConNorma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar las relaciones de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @relaciona_con_normas = []
      @relaciones_salientes = nil
      @relaciones_entrantes = nil
      if (not params[:id_norma].nil?)
        @norma = Norma.find(params[:id_norma])
        @relaciones_salientes = RelacionaConNorma.buscar_relaciones_salientes(@norma)
        @relaciones_entrantes = RelacionaConNorma.buscar_relaciones_entrantes(@norma)
      end

      respond_to do |format|
        format.html
        format.xml  { render :xml => @relaciona_con_normas }
      end
    end
  end

end
