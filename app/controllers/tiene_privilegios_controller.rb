class TienePrivilegiosController < ApplicationController
  before_action :set_tiene_privilegio, only: [:show, :edit, :update, :destroy]

  # GET /tiene_privilegios
  # GET /tiene_privilegios.json
  def index
    @tiene_privilegios = TienePrivilegio.all
  end

  # GET /tiene_privilegios/1
  # GET /tiene_privilegios/1.json
  def show
  end

  # GET /tiene_privilegios/new
  def new
    @tiene_privilegio = TienePrivilegio.new
  end

  # GET /tiene_privilegios/1/edit
  def edit
  end

  # POST /tiene_privilegios
  # POST /tiene_privilegios.json
  def create
    @tiene_privilegio = TienePrivilegio.new(tiene_privilegio_params)

    respond_to do |format|
      if @tiene_privilegio.save
        format.html { redirect_to @tiene_privilegio, notice: 'Tiene privilegio was successfully created.' }
        format.json { render :show, status: :created, location: @tiene_privilegio }
      else
        format.html { render :new }
        format.json { render json: @tiene_privilegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tiene_privilegios/1
  # PATCH/PUT /tiene_privilegios/1.json
  def update
    respond_to do |format|
      if @tiene_privilegio.update(tiene_privilegio_params)
        format.html { redirect_to @tiene_privilegio, notice: 'Tiene privilegio was successfully updated.' }
        format.json { render :show, status: :ok, location: @tiene_privilegio }
      else
        format.html { render :edit }
        format.json { render json: @tiene_privilegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tiene_privilegios/1
  # DELETE /tiene_privilegios/1.json
  def destroy
    @tiene_privilegio.destroy
    respond_to do |format|
      format.html { redirect_to tiene_privilegios_url, notice: 'Tiene privilegio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tiene_privilegio
      @tiene_privilegio = TienePrivilegio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tiene_privilegio_params
      params.require(:tiene_privilegio).permit(:usuario_id, :privilegio_id)
    end
end
