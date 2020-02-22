class LugarPublicacionsController < ApplicationController
  before_action :set_lugar_publicacion, only: [:show, :edit, :update, :destroy]

  # GET /lugar_publicacions
  # GET /lugar_publicacions.json
  def index
    @lugar_publicacions = LugarPublicacion.all
  end

  # GET /lugar_publicacions/1
  # GET /lugar_publicacions/1.json
  def show
  end

  # GET /lugar_publicacions/new
  def new
    @lugar_publicacion = LugarPublicacion.new
  end

  # GET /lugar_publicacions/1/edit
  def edit
  end

  # POST /lugar_publicacions
  # POST /lugar_publicacions.json
  def create
    @lugar_publicacion = LugarPublicacion.new(lugar_publicacion_params)

    respond_to do |format|
      if @lugar_publicacion.save
        format.html { redirect_to @lugar_publicacion, notice: 'Lugar publicacion was successfully created.' }
        format.json { render :show, status: :created, location: @lugar_publicacion }
      else
        format.html { render :new }
        format.json { render json: @lugar_publicacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lugar_publicacions/1
  # PATCH/PUT /lugar_publicacions/1.json
  def update
    respond_to do |format|
      if @lugar_publicacion.update(lugar_publicacion_params)
        format.html { redirect_to @lugar_publicacion, notice: 'Lugar publicacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @lugar_publicacion }
      else
        format.html { render :edit }
        format.json { render json: @lugar_publicacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lugar_publicacions/1
  # DELETE /lugar_publicacions/1.json
  def destroy
    @lugar_publicacion.destroy
    respond_to do |format|
      format.html { redirect_to lugar_publicacions_url, notice: 'Lugar publicacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lugar_publicacion
      @lugar_publicacion = LugarPublicacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lugar_publicacion_params
      params.require(:lugar_publicacion).permit(:nombre, :comentario)
    end
end
