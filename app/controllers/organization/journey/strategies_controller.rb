class Organization::Journey::StrategiesController < Organization::Journey::Strategies::BaseController
  def index
    @strategies = [{
      name: "Password",
      path: new_organization_password_authentication_path,
      icon: "password.svg"
    }]

    if Journey.explorer&.keyring
      @strategies.push({
        name: "Passkey",
        path: new_organization_passkey_authentication_path,
        icon: "passkey.svg"
      })
    end
  end
end
