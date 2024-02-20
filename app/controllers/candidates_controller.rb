class CandidatesController < ApplicationController
  before_action :set_candidate, only: %i[ show edit update destroy ]

  # GET /candidates or /candidates.json
  def index
    @candidates = Candidate.all
  end

  # GET /candidates/1 or /candidates/1.json
  def show
  end

  # GET /candidates/new
  def new
    # @candidate = Candidate.new
    @event = Event.find(params[:v])
    @candidate = @event.candidates.build
    # set_dummy_data
  end

  def set_dummy_data 
    @candidate.name = FFaker::Name.name
  end

  # GET /candidates/1/edit
  def edit
  end

  # POST /candidates or /candidates.json
  def create
    # @candidate = Candidate.new(candidate_params)
    @event = Event.find(params[:v])
    @candidate = @event.candidates.build(candidate_params)
    respond_to do |format|
      if @candidate.save
        format.html { redirect_to @event, notice: "Candidate was successfully created." }
        format.json { render :show, status: :created, location: @candidate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidates/1 or /candidates/1.json
  def update
    @event = Event.find(@candidate.event_id)
    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to candidate_url(@candidate), notice: "Candidate was successfully updated." }
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1 or /candidates/1.json
  def destroy
    @candidate.destroy

    respond_to do |format|
      format.html { redirect_to candidates_url, notice: "Candidate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
      @event = Event.find(@candidate.event_id)
    end

    # Only allow a list of trusted parameters through.
    def candidate_params
      params.require(:candidate).permit(:event_id, :position_id, :name, :remark, :picture)
    end
end
