class AgregarPrivilegiosController < ApplicationController
  before_action :set_agregar_privilegio, only: [:show, :edit, :update, :destroy]

  # GET /agregar_privilegios
  # GET /agregar_privilegios.json
  def index
    @agregar_privilegios = AgregarPrivilegio.all
  end

  # GET /agregar_privilegios/1
  # GET /agregar_privilegios/1.json
  def show
  end

  # GET /agregar_privilegios/new
  def new
    @agregar_privilegio = AgregarPrivilegio.new
  end

  # GET /agregar_privilegios/1/edit
  def edit
  end

  # POST /agregar_privilegios
  # POST /agregar_privilegios.json
  def create
    @agregar_privilegio = AgregarPrivilegio.new(agregar_privilegio_params)

    respond_to do |format|
      if @agregar_privilegio.save
        format.html { redirect_to @agregar_privilegio, notice: 'Agregar privilegio was successfully created.' }
        format.json { render :show, status: :created, location: @agregar_privilegio }
      else
        format.html { render :new }
        format.json { render json: @agregar_privilegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agregar_privilegios/1
  # PATCH/PUT /agregar_privilegios/1.json
  def update
    respond_to do |format|
      if @agregar_privilegio.update(agregar_privilegio_params)
        format.html { redirect_to @agregar_privilegio, notice: 'Agregar privilegio was successfully updated.' }
        format.json { render :show, status: :ok, location: @agregar_privilegio }
      else
        format.html { render :edit }
        format.json { render json: @agregar_privilegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agregar_privilegios/1
  # DELETE /agregar_privilegios/1.json
  def destroy
    @agregar_privilegio.destroy
    respond_to do |format|
      format.html { redirect_to agregar_privilegios_url, notice: 'Agregar privilegio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agregar_privilegio
      @agregar_privilegio = AgregarPrivilegio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def agregar_privilegio_params
      params.require(:agregar_privilegio).permit(:Privilegio_id, :Patron_privilegio_id)
    end
end
