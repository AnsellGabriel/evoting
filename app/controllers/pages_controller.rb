class PagesController < ApplicationController
    def home 
        @events  = Event.where(active: 1)
    end
    def voter_code 
        @election = Election.new
    end
    def enter_code 
        # puts "@@@ create"
        @election = Election.new(election_params)
        @member = Member.find_by(vote_code: @election.voter_code)
        @position = Position.find(params[:p])
        #  raise "errors"
        respond_to do |format|
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
      @position = Position.find(params[:p])
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
