class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit update destroy ]

  # GET /votes or /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1 or /votes/1.json
  def show
  end

  def results_graph
    @event = Event.find_by(active: 1)
    @positions = Position.where(event: @event)
    results = Vote.group(:candidate_id).count
    @graph = results.map { |candidate, count| [candidate, count] }
    @member = Member.where(event: @event).all
    # results_with_name = Vote.joins(:candidate).group('candidates.name').count
    # @graph_with_name = results_with_name.map { |candidate_name, count| [candidate_name, count] }
  end

  # GET /votes/new
  def new
    @vote = Vote.new
    @candidate = Candidate.find(params[:c])
    @member = Member.find(params[:m])
    @position = Position.find(@candidate.position_id)
    @vote.candidate = @candidate
    @vote.member = @member
    @vote.event_id = @member.event_id
    @vote.position = @candidate.position
  end

  # GET /votes/1/edit
  def edit
  end

  def save_vote
    @vote = Vote.new
    @candidate = Candidate.find(params[:c])
    @position = Position.find(@candidate.position_id)
    @member = Member.find(params[:m])
    @event = Event.find(@member.event_id)
    @vote.candidate = @candidate
    @vote.member = @member
    @vote.event = @event
    @vote.position = @candidate.position
    respond_to do |format|
      if @vote.save
        format.html { redirect_to page_vote_path(i: @member, p: @candidate.position), notice: "Vote was successfully created." }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def vote_all
    @member = Member.find(params[:i])
    @position = Position.find(params[:p])
    @event = Event.find(@member.event_id)
    @candidates = Candidate.where(position: @position)
    @candidates.each do |can|
      @vote = Vote.new
      @vote.candidate = can
      @vote.member = @member
      @vote.event = @event
      @vote.position = @position
      @vote.save
    end
    respond_to do |format|
      format.html { redirect_to page_vote_path(i: @member, p: @position), notice: "Vote was successfully created." }
      format.json { render :show, status: :created, location: @vote }
    end
  end

  # POST /votes or /votes.json
  def create
    @vote = Vote.new(vote_params)
    @member = @vote.member
    @position = @vote.position
    # raise "errors"
    respond_to do |format|
      if @vote.save
        format.html { redirect_to page_vote_url(i: @member, p: @position), notice: "Vote was successfully created." }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1 or /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to vote_url(@vote), notice: "Vote was successfully updated." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1 or /votes/1.json
  def destroy
    @member = @vote.member
    @candidate = @vote.candidate
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to page_vote_path(i: @member, p: @candidate.position), notice: "Vote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def vote_review
    @member = Member.find(params[:m])
    @event = Event.find_by(active: 1)
    @positions = Position.where(event: @event)

    # @referendum_response = ReferendumResponse.new
    @referendums = ReferendumResponse.where(member: @member)
  end

  def vote_final
    @member = Member.find(params[:m])

    # @votes = Vote.where(event_hub: @event_hub, coop_event: @event_hub.coop_event)

    if current_user
      # if @member.update!(voted: 1, vote_date: Time.now)
      if @member.update!(voted: 1, vote_date: Time.now, user_id: current_user.id)
        @vote_update = Vote.where(member: @member)
        @vote_update.update_all(post: 1)
        redirect_to vote_success_votes_path
      end
    else
      if @member.update!(voted: 1, vote_date: Date.today)
        @vote_update = Vote.where(member: @member)
        @vote_update.update_all(post: 1)
        redirect_to vote_success_votes_path
      end
    end
  end

  def vote_success
    @event = Event.find_by(active: 1)
  end

  def result
    @event = Event.find_by(active: 1)
    @positions = Position.where(event: @my_event)
    @count_voter = Member.where(voted: 1).count
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vote
    @vote = Vote.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vote_params
    params.require(:vote).permit(:event_id, :candidate_id, :member_id, :position_id, :vote_amount, :station, :vote_code)
  end
end
