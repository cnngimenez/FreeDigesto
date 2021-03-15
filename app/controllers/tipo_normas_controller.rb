# coding: utf-8

    # tipo_normas_controller.rb
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


class TipoNormasController < ApplicationController
  # GET /tipo_normas
  # GET /tipo_normas.xml
  def index
    if not verificar_privilegios(TipoNorma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los tipos de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tipo_normas = TipoNorma.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @tipo_normas }
      end
    end
  end

  # GET /tipo_normas/1
  # GET /tipo_normas/1.xml
  def show
    if not verificar_privilegios(TipoNorma::PuedeConsultar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede consultar los tipos de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tipo_norma = TipoNorma.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @tipo_norma }
      end
    end
  end

  # GET /tipo_normas/new
  # GET /tipo_normas/new.xml
  def new
    if not verificar_privilegios(TipoNorma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear tipos de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tipo_norma = TipoNorma.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @tipo_norma }
      end
    end
  end

  # GET /tipo_normas/1/edit
  def edit
    if not verificar_privilegios(TipoNorma::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar tipos de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tipo_norma = TipoNorma.find(params[:id])
    end
  end

  # POST /tipo_normas
  # POST /tipo_normas.xml
  def create
    if not verificar_privilegios(TipoNorma::PuedeCrear)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede crear tipos de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tipo_norma = TipoNorma.new(params[:tipo_norma])

      respond_to do |format|
        if @tipo_norma.save
          flash[:notice] = 'Se ha creado el tipo de norma exitósamente.'
          format.html { redirect_to(@tipo_norma) }
          format.xml  { render :xml => @tipo_norma, :status => :created, :location => @tipo_norma }
        else
          flash[:notice] = '¡Surgió un error al crear el tipo de norma!'
          format.html { render :action => "new" }
          format.xml  { render :xml => @tipo_norma.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /tipo_normas/1
  # PUT /tipo_normas/1.xml
  def update
    if not verificar_privilegios(TipoNorma::PuedeEditar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede editar tipos de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tipo_norma = TipoNorma.find(params[:id])

      respond_to do |format|
        if @tipo_norma.update_attributes(params[:tipo_norma])
          flash[:notice] = 'Se ha actualizado el tipo de norma exitósamente.'
          format.html { redirect_to(@tipo_norma) }
          format.xml  { head :ok }
        else
          flash[:notice] = '¡Surgió un error al actualizar el tipo de norma!'
          format.html { render :action => "edit" }
          format.xml  { render :xml => @tipo_norma.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /tipo_normas/1
  # DELETE /tipo_normas/1.xml
  def destroy
    if not verificar_privilegios(TipoNorma::PuedeEliminar)
      #No tiene derechos para ver index.
      flash[:notice] = "¡Usted no puede eliminar tipos de normas!"
      respond_to do |format|
        format.html { redirect_to :controller => 'pagina_principal'}
        format.xml { head :ok}
      end

    else
      @tipo_norma = TipoNorma.find(params[:id])
      @tipo_norma.destroy

      respond_to do |format|
        format.html { redirect_to(tipo_normas_url) }
        format.xml  { head :ok }
      end
    end
  end
end
