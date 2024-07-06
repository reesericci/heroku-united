class My::JourneysController < My::Journey::BaseController
  def new
    basecamp = Journey.basecamp
    Journey.reset
    Journey.basecamp = basecamp
  end

  def create
    Journey.explorer = Member.find_by(username: member_params[:username].downcase)
    redirect_to my_journey_strategies_path, status: :see_other
  end

  def delete
    request.env["warden"].logout(:my)
    redirect_to new_my_journey_path
  end

  private

  def member_params
    params.require(:member).permit(:username)
  end
end
