class ElecomsController < ApplicationController
  before_action :set_elecom, only: %i[ show edit update destroy ]

  # GET /elecoms or /elecoms.json
  def index
    @elecoms = Elecom.all
  end

  # GET /elecoms/1 or /elecoms/1.json
  def show
  end

  # GET /elecoms/new
  def new
    @elecom = Elecom.new
    @elecom.event = Event.find_by(active: 1)
  end

  # GET /elecoms/1/edit
  def edit
  end

  # POST /elecoms or /elecoms.json
  def create
    @elecom = Elecom.new(elecom_params)
    respond_to do |format|
      if @elecom.save
        format.html { redirect_to elecom_url(@elecom), notice: "Elecom was successfully created." }
        format.json { render :show, status: :created, location: @elecom }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @elecom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /elecoms/1 or /elecoms/1.json
  def update
    respond_to do |format|
      if @elecom.update(elecom_params)
        format.html { redirect_to elecom_url(@elecom), notice: "Elecom was successfully updated." }
        format.json { render :show, status: :ok, location: @elecom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @elecom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elecoms/1 or /elecoms/1.json
  def destroy
    @elecom.destroy

    respond_to do |format|
      format.html { redirect_to elecoms_url, notice: "Elecom was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_elecom
      @elecom = Elecom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def elecom_params
      params.require(:elecom).permit(:event_id, :name, :position)
    end
end
