class PrivilegiosController < ApplicationController
  before_action :set_privilegio, only: [:show, :edit, :update, :destroy]

  # GET /privilegios
  # GET /privilegios.json
  def index
    @privilegios = Privilegio.all
  end

  # GET /privilegios/1
  # GET /privilegios/1.json
  def show
  end

  # GET /privilegios/new
  def new
    @privilegio = Privilegio.new
  end

  # GET /privilegios/1/edit
  def edit
  end

  # POST /privilegios
  # POST /privilegios.json
  def create
    @privilegio = Privilegio.new(privilegio_params)

    respond_to do |format|
      if @privilegio.save
        format.html { redirect_to @privilegio, notice: 'Privilegio was successfully created.' }
        format.json { render :show, status: :created, location: @privilegio }
      else
        format.html { render :new }
        format.json { render json: @privilegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /privilegios/1
  # PATCH/PUT /privilegios/1.json
  def update
    respond_to do |format|
      if @privilegio.update(privilegio_params)
        format.html { redirect_to @privilegio, notice: 'Privilegio was successfully updated.' }
        format.json { render :show, status: :ok, location: @privilegio }
      else
        format.html { render :edit }
        format.json { render json: @privilegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /privilegios/1
  # DELETE /privilegios/1.json
  def destroy
    @privilegio.destroy
    respond_to do |format|
      format.html { redirect_to privilegios_url, notice: 'Privilegio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_privilegio
      @privilegio = Privilegio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def privilegio_params
      params.require(:privilegio).permit(:nombre, :comentario)
    end
end
