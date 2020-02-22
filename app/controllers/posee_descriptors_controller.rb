class PoseeDescriptorsController < ApplicationController
  before_action :set_posee_descriptor, only: [:show, :edit, :update, :destroy]

  # GET /posee_descriptors
  # GET /posee_descriptors.json
  def index
    @posee_descriptors = PoseeDescriptor.all
  end

  # GET /posee_descriptors/1
  # GET /posee_descriptors/1.json
  def show
  end

  # GET /posee_descriptors/new
  def new
    @posee_descriptor = PoseeDescriptor.new
  end

  # GET /posee_descriptors/1/edit
  def edit
  end

  # POST /posee_descriptors
  # POST /posee_descriptors.json
  def create
    @posee_descriptor = PoseeDescriptor.new(posee_descriptor_params)

    respond_to do |format|
      if @posee_descriptor.save
        format.html { redirect_to @posee_descriptor, notice: 'Posee descriptor was successfully created.' }
        format.json { render :show, status: :created, location: @posee_descriptor }
      else
        format.html { render :new }
        format.json { render json: @posee_descriptor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posee_descriptors/1
  # PATCH/PUT /posee_descriptors/1.json
  def update
    respond_to do |format|
      if @posee_descriptor.update(posee_descriptor_params)
        format.html { redirect_to @posee_descriptor, notice: 'Posee descriptor was successfully updated.' }
        format.json { render :show, status: :ok, location: @posee_descriptor }
      else
        format.html { render :edit }
        format.json { render json: @posee_descriptor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posee_descriptors/1
  # DELETE /posee_descriptors/1.json
  def destroy
    @posee_descriptor.destroy
    respond_to do |format|
      format.html { redirect_to posee_descriptors_url, notice: 'Posee descriptor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posee_descriptor
      @posee_descriptor = PoseeDescriptor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def posee_descriptor_params
      params.require(:posee_descriptor).permit(:norma_id, :descriptor_general_id)
    end
end
