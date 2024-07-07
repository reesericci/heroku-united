class Organization::PasswordStrategy < Warden::Strategies::Base
  def valid?
    journey_params.permitted?
  end

  def authenticate!
    c = Journey.explorer&.authenticate(journey_params[:password])
    if c == false || c.nil?
      fail!("Could not log in")
    else
      success!(c)
    end
  end

  private

  def journey_params
    ActionController::Parameters.new(params).require(:journey).permit(:password)
  end
end
