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
    LoginsController.action(:new).call(env)
  end
end

Rails.application.config.to_prepare do
  # Password strategy
  Warden::Strategies.add(:password) do
    def valid?
      login_params.permitted?
    end

    def authenticate!
      c = Config.find_by(email: login_params[:email].downcase)&.authenticate(login_params[:password])
      if c == false || c.nil?
        fail!("Could not log in")
      else
        success!(c)
      end
    end

    private

    def login_params
      ActionController::Parameters.new(params).require(:login).permit(:email, :password)
    end
  end

  # Postmark strategy
  Warden::Strategies.add(:postmark) do
    def valid?
      login_params.permitted?
    end

    def authenticate!
      m = Member.find_by(username: login_params[:username])
      if m&.imprint&.code&.authenticate!(login_params[:code])
        success!(m)
      else
        fail!("Could not log in")
      end
    end

    private

    def login_params
      ActionController::Parameters.new(params).require(:login).permit(:username, :code)
    end
  end
end
