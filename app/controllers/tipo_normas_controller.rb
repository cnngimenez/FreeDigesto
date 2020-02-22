class TipoNormasController < ApplicationController
  before_action :set_tipo_norma, only: [:show, :edit, :update, :destroy]

  # GET /tipo_normas
  # GET /tipo_normas.json
  def index
    @tipo_normas = TipoNorma.all
  end

  # GET /tipo_normas/1
  # GET /tipo_normas/1.json
  def show
  end

  # GET /tipo_normas/new
  def new
    @tipo_norma = TipoNorma.new
  end

  # GET /tipo_normas/1/edit
  def edit
  end

  # POST /tipo_normas
  # POST /tipo_normas.json
  def create
    @tipo_norma = TipoNorma.new(tipo_norma_params)

    respond_to do |format|
      if @tipo_norma.save
        format.html { redirect_to @tipo_norma, notice: 'Tipo norma was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_norma }
      else
        format.html { render :new }
        format.json { render json: @tipo_norma.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_normas/1
  # PATCH/PUT /tipo_normas/1.json
  def update
    respond_to do |format|
      if @tipo_norma.update(tipo_norma_params)
        format.html { redirect_to @tipo_norma, notice: 'Tipo norma was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_norma }
      else
        format.html { render :edit }
        format.json { render json: @tipo_norma.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_normas/1
  # DELETE /tipo_normas/1.json
  def destroy
    @tipo_norma.destroy
    respond_to do |format|
      format.html { redirect_to tipo_normas_url, notice: 'Tipo norma was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_norma
      @tipo_norma = TipoNorma.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tipo_norma_params
      params.require(:tipo_norma).permit(:nombre, :comentario)
    end
end
