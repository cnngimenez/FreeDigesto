class CambioAplicadosController < ApplicationController
  before_action :set_cambio_aplicado, only: [:show, :edit, :update, :destroy]

  # GET /cambio_aplicados
  # GET /cambio_aplicados.json
  def index
    @cambio_aplicados = CambioAplicado.all
  end

  # GET /cambio_aplicados/1
  # GET /cambio_aplicados/1.json
  def show
  end

  # GET /cambio_aplicados/new
  def new
    @cambio_aplicado = CambioAplicado.new
  end

  # GET /cambio_aplicados/1/edit
  def edit
  end

  # POST /cambio_aplicados
  # POST /cambio_aplicados.json
  def create
    @cambio_aplicado = CambioAplicado.new(cambio_aplicado_params)

    respond_to do |format|
      if @cambio_aplicado.save
        format.html { redirect_to @cambio_aplicado, notice: 'Cambio aplicado was successfully created.' }
        format.json { render :show, status: :created, location: @cambio_aplicado }
      else
        format.html { render :new }
        format.json { render json: @cambio_aplicado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cambio_aplicados/1
  # PATCH/PUT /cambio_aplicados/1.json
  def update
    respond_to do |format|
      if @cambio_aplicado.update(cambio_aplicado_params)
        format.html { redirect_to @cambio_aplicado, notice: 'Cambio aplicado was successfully updated.' }
        format.json { render :show, status: :ok, location: @cambio_aplicado }
      else
        format.html { render :edit }
        format.json { render json: @cambio_aplicado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cambio_aplicados/1
  # DELETE /cambio_aplicados/1.json
  def destroy
    @cambio_aplicado.destroy
    respond_to do |format|
      format.html { redirect_to cambio_aplicados_url, notice: 'Cambio aplicado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cambio_aplicado
      @cambio_aplicado = CambioAplicado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cambio_aplicado_params
      params.require(:cambio_aplicado).permit(:fecha_aplicado, :cambio_estado_id, :comentario)
    end
end
