class MembersController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :set_member, only: %i[ show edit update destroy ]

  # GET /members or /members.json
  def index
    @q = Member.ransack(params[:q])
    @pagy, @members = pagy(@q.result(distinct: true).order(created_at: :desc), items: 10)
    # @members = Member.all
  end

  # GET /members/1 or /members/1.json
  def show
  end

  # GET /members/new
  def new
    @event = Event.find_by(active: 1)
    @member = Member.new
    @member.event_id = @event.id
    code = SecureRandom.alphanumeric(4).upcase
    modified_string = code.gsub(/[1iO0I]/, "A")
    @member.vote_code = modified_string
    @member.name = FFaker::NamePH.name if Rails.env.development?
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)
    
    respond_to do |format|
      if @member.save
        format.html { redirect_to members_path, notice: "Member was successfully created." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to members_path, notice: "Member was successfully updated." }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url, notice: "Member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:event_id, :name, :description, :area, :voted, :vote_date, :station, :vote_code)
    end
end
