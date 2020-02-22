class DescriptorGeneralsController < ApplicationController
  before_action :set_descriptor_general, only: [:show, :edit, :update, :destroy]

  # GET /descriptor_generals
  # GET /descriptor_generals.json
  def index
    @descriptor_generals = DescriptorGeneral.all
  end

  # GET /descriptor_generals/1
  # GET /descriptor_generals/1.json
  def show
  end

  # GET /descriptor_generals/new
  def new
    @descriptor_general = DescriptorGeneral.new
  end

  # GET /descriptor_generals/1/edit
  def edit
  end

  # POST /descriptor_generals
  # POST /descriptor_generals.json
  def create
    @descriptor_general = DescriptorGeneral.new(descriptor_general_params)

    respond_to do |format|
      if @descriptor_general.save
        format.html { redirect_to @descriptor_general, notice: 'Descriptor general was successfully created.' }
        format.json { render :show, status: :created, location: @descriptor_general }
      else
        format.html { render :new }
        format.json { render json: @descriptor_general.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /descriptor_generals/1
  # PATCH/PUT /descriptor_generals/1.json
  def update
    respond_to do |format|
      if @descriptor_general.update(descriptor_general_params)
        format.html { redirect_to @descriptor_general, notice: 'Descriptor general was successfully updated.' }
        format.json { render :show, status: :ok, location: @descriptor_general }
      else
        format.html { render :edit }
        format.json { render json: @descriptor_general.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /descriptor_generals/1
  # DELETE /descriptor_generals/1.json
  def destroy
    @descriptor_general.destroy
    respond_to do |format|
      format.html { redirect_to descriptor_generals_url, notice: 'Descriptor general was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_descriptor_general
      @descriptor_general = DescriptorGeneral.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def descriptor_general_params
      params.require(:descriptor_general).permit(:nombre, :comentario)
    end
end
