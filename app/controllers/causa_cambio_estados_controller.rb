class CausaCambioEstadosController < ApplicationController
  before_action :set_causa_cambio_estado, only: [:show, :edit, :update, :destroy]

  # GET /causa_cambio_estados
  # GET /causa_cambio_estados.json
  def index
    @causa_cambio_estados = CausaCambioEstado.all
  end

  # GET /causa_cambio_estados/1
  # GET /causa_cambio_estados/1.json
  def show
  end

  # GET /causa_cambio_estados/new
  def new
    @causa_cambio_estado = CausaCambioEstado.new
  end

  # GET /causa_cambio_estados/1/edit
  def edit
  end

  # POST /causa_cambio_estados
  # POST /causa_cambio_estados.json
  def create
    @causa_cambio_estado = CausaCambioEstado.new(causa_cambio_estado_params)

    respond_to do |format|
      if @causa_cambio_estado.save
        format.html { redirect_to @causa_cambio_estado, notice: 'Causa cambio estado was successfully created.' }
        format.json { render :show, status: :created, location: @causa_cambio_estado }
      else
        format.html { render :new }
        format.json { render json: @causa_cambio_estado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /causa_cambio_estados/1
  # PATCH/PUT /causa_cambio_estados/1.json
  def update
    respond_to do |format|
      if @causa_cambio_estado.update(causa_cambio_estado_params)
        format.html { redirect_to @causa_cambio_estado, notice: 'Causa cambio estado was successfully updated.' }
        format.json { render :show, status: :ok, location: @causa_cambio_estado }
      else
        format.html { render :edit }
        format.json { render json: @causa_cambio_estado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /causa_cambio_estados/1
  # DELETE /causa_cambio_estados/1.json
  def destroy
    @causa_cambio_estado.destroy
    respond_to do |format|
      format.html { redirect_to causa_cambio_estados_url, notice: 'Causa cambio estado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_causa_cambio_estado
      @causa_cambio_estado = CausaCambioEstado.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def causa_cambio_estado_params
      params.require(:causa_cambio_estado).permit(:nombre, :comentario)
    end
end
