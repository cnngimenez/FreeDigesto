class PatronPrivilegiosController < ApplicationController
  before_action :set_patron_privilegio, only: [:show, :edit, :update, :destroy]

  # GET /patron_privilegios
  # GET /patron_privilegios.json
  def index
    @patron_privilegios = PatronPrivilegio.all
  end

  # GET /patron_privilegios/1
  # GET /patron_privilegios/1.json
  def show
  end

  # GET /patron_privilegios/new
  def new
    @patron_privilegio = PatronPrivilegio.new
  end

  # GET /patron_privilegios/1/edit
  def edit
  end

  # POST /patron_privilegios
  # POST /patron_privilegios.json
  def create
    @patron_privilegio = PatronPrivilegio.new(patron_privilegio_params)

    respond_to do |format|
      if @patron_privilegio.save
        format.html { redirect_to @patron_privilegio, notice: 'Patron privilegio was successfully created.' }
        format.json { render :show, status: :created, location: @patron_privilegio }
      else
        format.html { render :new }
        format.json { render json: @patron_privilegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patron_privilegios/1
  # PATCH/PUT /patron_privilegios/1.json
  def update
    respond_to do |format|
      if @patron_privilegio.update(patron_privilegio_params)
        format.html { redirect_to @patron_privilegio, notice: 'Patron privilegio was successfully updated.' }
        format.json { render :show, status: :ok, location: @patron_privilegio }
      else
        format.html { render :edit }
        format.json { render json: @patron_privilegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patron_privilegios/1
  # DELETE /patron_privilegios/1.json
  def destroy
    @patron_privilegio.destroy
    respond_to do |format|
      format.html { redirect_to patron_privilegios_url, notice: 'Patron privilegio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patron_privilegio
      @patron_privilegio = PatronPrivilegio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patron_privilegio_params
      params.require(:patron_privilegio).permit(:nombre, :comentario)
    end
end
