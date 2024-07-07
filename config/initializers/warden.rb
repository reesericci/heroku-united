# Setup middleware
Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :organization_password

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
  # Organization login strategies
  Warden::Strategies.add(:organization_password, Organization::PasswordStrategy)
  Warden::Strategies.add(:organization_passkey, Organization::PasskeyStrategy)

  # My login strategies
  Warden::Strategies.add(:my_keycode, My::KeycodeStrategy)
  Warden::Strategies.add(:my_passkey, My::PasskeyStrategy)
end
