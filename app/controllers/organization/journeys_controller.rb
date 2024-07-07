class Organization::JourneysController < Organization::Journey::BaseController
  def new
    basecamp = Journey.basecamp
    Journey.reset
    Journey.basecamp = basecamp
  end

  def create
    Journey.explorer = Config.find_by(email: config_params[:email].downcase)
    redirect_to organization_journey_strategies_path, status: :see_other
  end

  def delete
    request.env["warden"].logout
    redirect_to new_organization_journey_path
  end

  private

  def config_params
    params.require(:config).permit(:email)
  end
end
