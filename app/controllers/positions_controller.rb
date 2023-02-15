class PositionsController < ApplicationController
  before_action :set_position, only: %i[ show edit update destroy ]

  # GET /positions or /positions.json
  def index
    @positions = Position.all
  end

  # GET /positions/1 or /positions/1.json
  def show
  end

  # GET /positions/new
  def new
    # @position = Position.new
    @event = Event.find(params[:v])
    @position = @event.positions.build
  end

  # GET /positions/1/edit
  def edit
  end

  # POST /positions or /positions.json
  def create
    # @position = Position.new(position_params)
    @event = Event.find(params[:v])
    @position = @event.positions.build(position_params)
    respond_to do |format|
      if @position.save
        format.html { redirect_to @event, notice: "Position was successfully created." }
        format.json { render :show, status: :created, location: @position }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @position.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /positions/1 or /positions/1.json
  def update
    
    respond_to do |format|
      if @position.update(position_params)
        format.html { redirect_to @event, notice: "Position was successfully updated." }
        format.json { render :show, status: :ok, location: @position }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @position.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1 or /positions/1.json
  def destroy
    @position.destroy

    respond_to do |format|
      format.html { redirect_to positions_url, notice: "Position was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
      @event = Event.find(@position.event_id)
    end

    # Only allow a list of trusted parameters through.
    def position_params
      params.require(:position).permit(:event_id, :name, :vacant)
    end
end
