class PoseeDescPartsController < ApplicationController
  before_action :set_posee_desc_part, only: [:show, :edit, :update, :destroy]

  # GET /posee_desc_parts
  # GET /posee_desc_parts.json
  def index
    @posee_desc_parts = PoseeDescPart.all
  end

  # GET /posee_desc_parts/1
  # GET /posee_desc_parts/1.json
  def show
  end

  # GET /posee_desc_parts/new
  def new
    @posee_desc_part = PoseeDescPart.new
  end

  # GET /posee_desc_parts/1/edit
  def edit
  end

  # POST /posee_desc_parts
  # POST /posee_desc_parts.json
  def create
    @posee_desc_part = PoseeDescPart.new(posee_desc_part_params)

    respond_to do |format|
      if @posee_desc_part.save
        format.html { redirect_to @posee_desc_part, notice: 'Posee desc part was successfully created.' }
        format.json { render :show, status: :created, location: @posee_desc_part }
      else
        format.html { render :new }
        format.json { render json: @posee_desc_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posee_desc_parts/1
  # PATCH/PUT /posee_desc_parts/1.json
  def update
    respond_to do |format|
      if @posee_desc_part.update(posee_desc_part_params)
        format.html { redirect_to @posee_desc_part, notice: 'Posee desc part was successfully updated.' }
        format.json { render :show, status: :ok, location: @posee_desc_part }
      else
        format.html { render :edit }
        format.json { render json: @posee_desc_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posee_desc_parts/1
  # DELETE /posee_desc_parts/1.json
  def destroy
    @posee_desc_part.destroy
    respond_to do |format|
      format.html { redirect_to posee_desc_parts_url, notice: 'Posee desc part was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posee_desc_part
      @posee_desc_part = PoseeDescPart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def posee_desc_part_params
      params.require(:posee_desc_part).permit(:norma_id, :descriptor_particular_id)
    end
end
