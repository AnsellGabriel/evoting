class PagesController < ApplicationController
  def home
    @events = Event.where(active: 1)
  end

  def voter_code
    @election = Election.new
  end

  def enter_code
    # puts "@@@ create"
    @election = Election.new(election_params)
    @member = @my_event.members.find_by(vote_code: @election.voter_code)
    if @election.member.nil?
      # puts "@@@@ #{@member.vote_code}"
    else
      @member = Member.find(@election.member_id)
      # puts "@@@@ #{@member.vote_code}"
      @election.voter_code = @member.vote_code
    end
    @position = @my_event.positions.first
    # raise "errors"
    respond_to do |format|
      # raise "error"
      if @member.present?
        if @member.voted?
          format.html { redirect_to vote_check_votes_path(m: @member), notice: "Member was successfully created." }
        end
      end
      if @election.save
        format.html { redirect_to page_vote_url(i: @member, p: @position), notice: "Member was successfully created." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :voter_code, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def vote
    @member = Member.find(params[:i])
    # raise "error"
    @position = Position.find(params[:p])
    @next = params[:p].to_i + 1
    @next_position = Position.find_by(id: @next, event: @my_event)
    @count_vote = Vote.where(position: @position, member: @member).count
    # @event = Event.find(@member.event_id)
    @candidates = Candidate.where(position: @position, event: @my_event)
    @voted = Vote.where(position: @position, member: @member)
    # raise "errors"
  end

  def vote_all
    @member = Member.find(params[:i])
    @position = Position.find(params[:p])
    @event = Event.find(@member.event_id)
    @candidates = Candidate.where(position: @position, event: @event)
    @candidates.each do |can|
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    #   @member = Member.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def election_params
    params.require(:election).permit(:member_id, :voter_code, :station)
  end
end
