# Setup middleware
Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :password

  manager.serialize_into_session do |obj|
    obj.class.name + "_" + obj[obj.class.primary_key.to_sym].to_s
  end

  manager.serialize_from_session do |id|
    split = id.split "_"

    Object.const_get(split[0]).find(split[1])
  end

  manager.failure_app = ->(env) do
    env["REQUEST_METHOD"] = "GET"
    Organization::JourneysController.action(:new).call(env)
  end
end

Rails.application.config.to_prepare do
  # Password strategy
  Warden::Strategies.add(:password) do
    def valid?
      journey_params.permitted?
    end

    def authenticate!
      c = Config.find_by(email: journey_params[:email].downcase)&.authenticate(journey_params[:password])
      if c == false || c.nil?
        fail!("Could not log in")
      else
        success!(c)
      end
    end

    private

    def journey_params
      ActionController::Parameters.new(params).require(:journey).permit(:email, :password)
    end
  end

  # Keycode strategy
  Warden::Strategies.add(:keycode) do
    def valid?
      journey_params.permitted?
    end

    def authenticate!
      m = begin
        Member.find(journey_params[:username])
      rescue ActiveRecord::RecordNotFound
        nil
      end
      if m&.keycode_imprint&.authenticate!(journey_params[:code])
        m.verify
        success!(m)
      else
        fail!("Could not log in")
      end
    end

    private

    def journey_params
      ActionController::Parameters.new(params).require(:journey).permit(:username, :code)
    end
  end
end
