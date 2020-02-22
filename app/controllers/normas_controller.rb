class NormasController < ApplicationController
  before_action :set_norma, only: [:show, :edit, :update, :destroy]

  # GET /normas
  # GET /normas.json
  def index
    @normas = Norma.all
  end

  # GET /normas/1
  # GET /normas/1.json
  def show
  end

  # GET /normas/new
  def new
    @norma = Norma.new
  end

  # GET /normas/1/edit
  def edit
  end

  # POST /normas
  # POST /normas.json
  def create
    @norma = Norma.new(norma_params)

    respond_to do |format|
      if @norma.save
        format.html { redirect_to @norma, notice: 'Norma was successfully created.' }
        format.json { render :show, status: :created, location: @norma }
      else
        format.html { render :new }
        format.json { render json: @norma.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /normas/1
  # PATCH/PUT /normas/1.json
  def update
    respond_to do |format|
      if @norma.update(norma_params)
        format.html { redirect_to @norma, notice: 'Norma was successfully updated.' }
        format.json { render :show, status: :ok, location: @norma }
      else
        format.html { render :edit }
        format.json { render json: @norma.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /normas/1
  # DELETE /normas/1.json
  def destroy
    @norma.destroy
    respond_to do |format|
      format.html { redirect_to normas_url, notice: 'Norma was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_norma
      @norma = Norma.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def norma_params
      params.require(:norma).permit(:numero, :comentarios, :sumario, :citas_doctorales, :citas_jurisprudenciales, :general, :texto, :fecha_publicacion, :fecha_sancion, :fecha_promulgacion, :tipo_norma_id, :estado_id, :lugar_publicacion_id)
    end
end
