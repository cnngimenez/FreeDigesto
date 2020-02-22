class CambioEstadosController < ApplicationController
  before_action :set_cambio_estado, only: [:show, :edit, :update, :destroy]

  # GET /cambio_estados
  # GET /cambio_estados.json
  def index
    @cambio_estados = CambioEstado.all
  end

  # GET /cambio_estados/1
  # GET /cambio_estados/1.json
  def show
  end

  # GET /cambio_estados/new
  def new
    @cambio_estado = CambioEstado.new
  end

  # GET /cambio_estados/1/edit
  def edit
  end

  # POST /cambio_estados
  # POST /cambio_estados.json
  def create
    @cambio_estado = CambioEstado.new(cambio_estado_params)

    respond_to do |format|
      if @cambio_estado.save
        format.html { redirect_to @cambio_estado, notice: 'Cambio estado was successfully created.' }
        format.json { render :show, status: :created, location: @cambio_estado }
      else
        format.html { render :new }
        format.json { render json: @cambio_estado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cambio_estados/1
  # PATCH/PUT /cambio_estados/1.json
  def update
    respond_to do |format|
      if @cambio_estado.update(cambio_estado_params)
        format.html { redirect_to @cambio_estado, notice: 'Cambio estado was successfully updated.' }
        format.json { render :show, status: :ok, location: @cambio_estado }
      else
        format.html { render :edit }
        format.json { render json: @cambio_estado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cambio_estados/1
  # DELETE /cambio_estados/1.json
  def destroy
    @cambio_estado.destroy
    respond_to do |format|
      format.html { redirect_to cambio_estados_url, notice: 'Cambio estado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cambio_estado
      @cambio_estado = CambioEstado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cambio_estado_params
      params.require(:cambio_estado).permit(:fecha_cambio, :norma_id, :comentario, :fecha_creacion, :causa_cambio_estado_id, :estado_id)
    end
end
