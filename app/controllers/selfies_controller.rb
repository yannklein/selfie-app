class SelfiesController < ApplicationController
  before_action :set_selfy, only: %i[ show edit update destroy ]

  # GET /selfies or /selfies.json
  def index
    @selfies = Selfie.all
  end

  # GET /selfies/1 or /selfies/1.json
  def show
  end

  # GET /selfies/new
  def new
    @selfy = Selfie.new
  end

  # GET /selfies/1/edit
  def edit
  end

  # POST /selfies or /selfies.json
  def create
    @selfy = Selfie.new(selfy_params)
    respond_to do |format|
      if @selfy.save
        format.html { redirect_to @selfy, notice: "Selfie was successfully created." }
        format.json { render :show, status: :created, location: @selfy }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @selfy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /selfies/1 or /selfies/1.json
  def update
    respond_to do |format|
      if @selfy.update(selfy_params)
        format.html { redirect_to @selfy, notice: "Selfie was successfully updated." }
        format.json { render :show, status: :ok, location: @selfy }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @selfy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selfies/1 or /selfies/1.json
  def destroy
    @selfy.destroy
    respond_to do |format|
      format.html { redirect_to selfies_url, notice: "Selfie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_selfy
      @selfy = Selfie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def selfy_params
      params.require(:selfie).permit(:title, :photo)
    end
end
