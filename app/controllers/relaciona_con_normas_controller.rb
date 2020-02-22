class RelacionaConNormasController < ApplicationController
  before_action :set_relaciona_con_norma, only: [:show, :edit, :update, :destroy]

  # GET /relaciona_con_normas
  # GET /relaciona_con_normas.json
  def index
    @relaciona_con_normas = RelacionaConNorma.all
  end

  # GET /relaciona_con_normas/1
  # GET /relaciona_con_normas/1.json
  def show
  end

  # GET /relaciona_con_normas/new
  def new
    @relaciona_con_norma = RelacionaConNorma.new
  end

  # GET /relaciona_con_normas/1/edit
  def edit
  end

  # POST /relaciona_con_normas
  # POST /relaciona_con_normas.json
  def create
    @relaciona_con_norma = RelacionaConNorma.new(relaciona_con_norma_params)

    respond_to do |format|
      if @relaciona_con_norma.save
        format.html { redirect_to @relaciona_con_norma, notice: 'Relaciona con norma was successfully created.' }
        format.json { render :show, status: :created, location: @relaciona_con_norma }
      else
        format.html { render :new }
        format.json { render json: @relaciona_con_norma.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relaciona_con_normas/1
  # PATCH/PUT /relaciona_con_normas/1.json
  def update
    respond_to do |format|
      if @relaciona_con_norma.update(relaciona_con_norma_params)
        format.html { redirect_to @relaciona_con_norma, notice: 'Relaciona con norma was successfully updated.' }
        format.json { render :show, status: :ok, location: @relaciona_con_norma }
      else
        format.html { render :edit }
        format.json { render json: @relaciona_con_norma.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relaciona_con_normas/1
  # DELETE /relaciona_con_normas/1.json
  def destroy
    @relaciona_con_norma.destroy
    respond_to do |format|
      format.html { redirect_to relaciona_con_normas_url, notice: 'Relaciona con norma was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relaciona_con_norma
      @relaciona_con_norma = RelacionaConNorma.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def relaciona_con_norma_params
      params.require(:relaciona_con_norma).permit(:norma_a_id, :norma_b_id, :tipo_relacion_id)
    end
end
