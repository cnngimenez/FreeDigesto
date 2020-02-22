class TipoRelacionsController < ApplicationController
  before_action :set_tipo_relacion, only: [:show, :edit, :update, :destroy]

  # GET /tipo_relacions
  # GET /tipo_relacions.json
  def index
    @tipo_relacions = TipoRelacion.all
  end

  # GET /tipo_relacions/1
  # GET /tipo_relacions/1.json
  def show
  end

  # GET /tipo_relacions/new
  def new
    @tipo_relacion = TipoRelacion.new
  end

  # GET /tipo_relacions/1/edit
  def edit
  end

  # POST /tipo_relacions
  # POST /tipo_relacions.json
  def create
    @tipo_relacion = TipoRelacion.new(tipo_relacion_params)

    respond_to do |format|
      if @tipo_relacion.save
        format.html { redirect_to @tipo_relacion, notice: 'Tipo relacion was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_relacion }
      else
        format.html { render :new }
        format.json { render json: @tipo_relacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_relacions/1
  # PATCH/PUT /tipo_relacions/1.json
  def update
    respond_to do |format|
      if @tipo_relacion.update(tipo_relacion_params)
        format.html { redirect_to @tipo_relacion, notice: 'Tipo relacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_relacion }
      else
        format.html { render :edit }
        format.json { render json: @tipo_relacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_relacions/1
  # DELETE /tipo_relacions/1.json
  def destroy
    @tipo_relacion.destroy
    respond_to do |format|
      format.html { redirect_to tipo_relacions_url, notice: 'Tipo relacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_relacion
      @tipo_relacion = TipoRelacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tipo_relacion_params
      params.require(:tipo_relacion).permit(:nombre, :comentario)
    end
end
