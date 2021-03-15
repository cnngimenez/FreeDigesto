# coding: utf-8

    # cambio_aplicados_controller.rb
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


class CambioAplicadosController < ApplicationController
  # GET /cambio_aplicados
  # GET /cambio_aplicados.xml
  def index
    if not verificar_privilegios(CambioAplicado::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los cambios aplicados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_aplicados = CambioAplicado.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @cambio_aplicados }
      end
   end
  end

  # GET /cambio_aplicados/1
  # GET /cambio_aplicados/1.xml
  def show
   if not verificar_privilegios(CambioAplicado::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los cambios aplicados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_aplicado = CambioAplicado.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @cambio_aplicado }
      end
   end
  end

  # GET /cambio_aplicados/new
  # GET /cambio_aplicados/new.xml
  def new
   if not verificar_privilegios(CambioAplicado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los cambios aplicados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_aplicado = CambioAplicado.new

      #Obtener el cambio de estado que le pertenece.
      if params[:ce_id].nil?
        #¡No hay cambio de estado el cual asociar!
        #¡salir de inmediato!
        flash[:notice] = "¡Debe elegir un Cambio de Estado el cual aplicar!"
        redirect_to :back
        return
      else
        @cambio_estado = CambioEstado.find(params[:ce_id])
        if @cambio_estado.nil?
          flash[:notice] = "¡Debe elegir un Cambio de Estado existente el cual aplicar!"
          redirect_to :back
          return
        end

        @cambio_aplicado.cambio_estado = @cambio_estado
      end

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @cambio_aplicado }
      end
   end
  end

  # GET /cambio_aplicados/1/edit
  def edit
   if not verificar_privilegios(CambioAplicado::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los cambios aplicados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_aplicado = CambioAplicado.find(params[:id])
   end
  end

  # POST /cambio_aplicados
  # POST /cambio_aplicados.xml
  def create
    if not verificar_privilegios(CambioAplicado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los cambios aplicados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_aplicado = CambioAplicado.new(params[:cambio_aplicado])
      @cambio_aplicado.cambio_estado = CambioEstado.find(params[:ce_id])
      @cambio_aplicado.fecha_aplicado = Time.now


      respond_to do |format|
        if @cambio_aplicado.save
          flash[:notice] = 'Ha aplicado el cambio con éxito.'
          format.html { redirect_to(@cambio_aplicado) }
          format.xml  { render :xml => @cambio_aplicado, :status => :created, :location => @cambio_aplicado }
        else
          flash[:notice] = '¡Surgió un error al aplicar el cambio!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @cambio_aplicado.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /cambio_aplicados/1
  # PUT /cambio_aplicados/1.xml
  def update
    if not verificar_privilegios(CambioAplicado::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los cambios aplicados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_aplicado = CambioAplicado.find(params[:id])

      respond_to do |format|
        if @cambio_aplicado.update_attributes(params[:cambio_aplicado])
          flash[:notice] = 'Ha editado el cambio aplicado con éxito.'
          format.html { redirect_to(@cambio_aplicado) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al guardar su modificación!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @cambio_aplicado.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /cambio_aplicados/1
  # DELETE /cambio_aplicados/1.xml
  def destroy
    if not verificar_privilegios(CambioAplicado::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar los cambios aplicados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_aplicado = CambioAplicado.find(params[:id])
      @cambio_aplicado.destroy

      respond_to do |format|
        format.html { redirect_to(cambio_aplicados_url) }
        format.xml  { head :ok }
      end
    end
  end
end
