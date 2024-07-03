class My::Journey::StrategiesController < My::Journey::BaseController
  def index
    @strategies = [{
      name: "Keycode",
      path: new_my_keycode_authentication_path,
      icon: "123.svg"
    }]

    if Journey.explorer.keyring
      @strategies.push({
        name: "Passkey",
        path: new_my_passkey_authentication_path,
        icon: "passkey.svg"
      })
    end
  end
end
