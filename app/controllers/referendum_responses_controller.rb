class ReferendumResponsesController < ApplicationController
    before_action :set_referendum_response, only: %i[ show edit update destroy ]

    def index
        @referendum_responses = ReferendumResponse.all
    end

    def new 
        @event = Event.find_by(active: 1)
        @referendums = Referendum.where(event: @event, active: 1)
        @member = Member.find(params[:i])
        # @referendum_response = ReferendumResponse.new
        # @referendum_response = @referendums.referendum_responses.build
    end
    def create
        @answer = ReferendumResponse.build(referendum_response_params)
        if @answer.save
          redirect_to root_path, notice: "Answers submitted successfully."
        else
        #   render :index
        end
    end
    private
        # Use callbacks to share common setup or constraints between actions.
        def set_referendum_response
        @referendum_response = ReferendumResponse.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def referendum_response_params
        params.require(:referendum).permit(:member_id, :referendum_id, :response)
        end
end
