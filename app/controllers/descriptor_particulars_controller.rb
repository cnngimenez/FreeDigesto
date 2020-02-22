class DescriptorParticularsController < ApplicationController
  before_action :set_descriptor_particular, only: [:show, :edit, :update, :destroy]

  # GET /descriptor_particulars
  # GET /descriptor_particulars.json
  def index
    @descriptor_particulars = DescriptorParticular.all
  end

  # GET /descriptor_particulars/1
  # GET /descriptor_particulars/1.json
  def show
  end

  # GET /descriptor_particulars/new
  def new
    @descriptor_particular = DescriptorParticular.new
  end

  # GET /descriptor_particulars/1/edit
  def edit
  end

  # POST /descriptor_particulars
  # POST /descriptor_particulars.json
  def create
    @descriptor_particular = DescriptorParticular.new(descriptor_particular_params)

    respond_to do |format|
      if @descriptor_particular.save
        format.html { redirect_to @descriptor_particular, notice: 'Descriptor particular was successfully created.' }
        format.json { render :show, status: :created, location: @descriptor_particular }
      else
        format.html { render :new }
        format.json { render json: @descriptor_particular.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /descriptor_particulars/1
  # PATCH/PUT /descriptor_particulars/1.json
  def update
    respond_to do |format|
      if @descriptor_particular.update(descriptor_particular_params)
        format.html { redirect_to @descriptor_particular, notice: 'Descriptor particular was successfully updated.' }
        format.json { render :show, status: :ok, location: @descriptor_particular }
      else
        format.html { render :edit }
        format.json { render json: @descriptor_particular.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /descriptor_particulars/1
  # DELETE /descriptor_particulars/1.json
  def destroy
    @descriptor_particular.destroy
    respond_to do |format|
      format.html { redirect_to descriptor_particulars_url, notice: 'Descriptor particular was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_descriptor_particular
      @descriptor_particular = DescriptorParticular.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def descriptor_particular_params
      params.require(:descriptor_particular).permit(:nombre, :comentario, :descriptor_general_id)
    end
end
