
    # cambio_estados_controller.rb
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


class CambioEstadosController < ApplicationController
  def index
    if not verificar_privilegios(CambioEstado::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      if params[:id].nil?
        #No hay id de norma
        flash[:notice] = "¡Debe indicar una norma!"
        redirect_to :back
        return
      end
      
    @norma = Norma.find(params[:id])
    @estado_actual = @norma.obtener_estado_actual()
    
    respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @cambio_estados }
      end
    end
  end

  # GET /cambio_estados
  # GET /cambio_estados.xml
  def listing
    if not verificar_privilegios(CambioEstado::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_estados = CambioEstado.find(:all)      

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @cambio_estados }
      end
    end
  end

  # GET /cambio_estados/1
  # GET /cambio_estados/1.xml
  def show
    if not verificar_privilegios(CambioEstado::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_estado = CambioEstado.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @cambio_estado }
      end
    end
  end

  # GET /cambio_estados/new
  # GET /cambio_estados/new.xml
  def nuevo_plan
    if not verificar_privilegios(CambioEstado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_estado = CambioEstado.new
      @norma = Norma.find(params[:id])

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @cambio_estado }
      end
    end
  end

    # GET /cambio_estados/new
  # GET /cambio_estados/new.xml
  def cambio_inmediato
    if not verificar_privilegios(CambioEstado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_estado = CambioEstado.new
      @norma = Norma.find(params[:id])

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @cambio_estado }
      end
    end
  end

  # GET /cambio_estados/1/edit
  def edit
    if not verificar_privilegios(CambioEstado::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_estado = CambioEstado.find(params[:id])
    end
  end

  # POST /cambio_estados
  # POST /cambio_estados.xml
  def create
    if not verificar_privilegios(CambioEstado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_estado = CambioEstado.new(params[:cambio_estado])
      @norma = Norma.find(params[:id])
      @cambio_estado.norma =  @norma
      @cambio_estado.fecha_creacion = Time.now.strftime("%Y-%m-%d")

      respond_to do |format|
        if @cambio_estado.save
          flash[:notice] = 'Su planificación ha sido creada con éxito.'
          format.html { redirect_to(@cambio_estado) }
          format.xml  { render :xml => @cambio_estado, :status => :created, :location => @cambio_estado }
        else
          flash[:notice] = '¡Ha surgido un error al crear su planificación!'
          format.html { render :action => "nuevo_plan", :id => @norma }
          format.xml  { render :xml => @cambio_estado.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def cambiar_ahora
    if not verificar_privilegios(CambioEstado::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      estado_id = params[:cambiar_ahora][:estado_id]
      comentario = params[:cambiar_ahora][:comentario]
      @norma = Norma.find(params[:id])
      causa_cambio_estado = CausaCambioEstado.find(params[:cambiar_ahora][:causa_cambio_estado_id])
      @ca = Norma.asignar_estado(estado_id, comentario, @norma, causa_cambio_estado)

      respond_to do |format|
        if not @ca.nil?
          flash[:notice] = 'Se ha aplicado el cambio de estado con éxito.'
          format.html { redirect_to(@ca) }
          format.xml  { render :xml => @ca, :status => :created, :location => @ca }
        else          
          flash[:notice] = "¡No se ha podido cambiar el estado!Si hoy cambio el estado
anteriormente, intente editar el cambio aplicado previo."
          format.html { render :action => "cambio_inmediato", :id => @norma }
          format.xml  { render :xml => @ca.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  # PUT /cambio_estados/1
  # PUT /cambio_estados/1.xml
  def update
    if not verificar_privilegios(CambioEstado::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_estado = CambioEstado.find(params[:id])
      #estado_id = params[:estado_id]
      #comentario = params[:comentario]
      #norma = Norma.find(params[:norma_id])
      #Norma.asignar_estado(estado_id, comentario, norma)

      respond_to do |format|
        if @cambio_estado.update_attributes(params[:cambio_estado])
          flash[:notice] = 'Se ha actualizado la planificación con éxito.'
          format.html { redirect_to(@cambio_estado) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Ha surgido un error al actualizar la planificación!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @cambio_estado.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /cambio_estados/1
  # DELETE /cambio_estados/1.xml
  def destroy
    if not verificar_privilegios(CambioEstado::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar los cambios de estados!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end
    else
      @cambio_estado = CambioEstado.find(params[:id])
      @cambio_estado.destroy

      respond_to do |format|
        format.html { redirect_to(cambio_estados_url) }
        format.xml  { head :ok }
      end
    end
  end

  
  
end
