class My::KeycodeStrategy < Warden::Strategies::Base
  def valid?
    keycode_params.permitted?
  end

  def authenticate!
    m = Journey.explorer
    if m&.keycode_imprint&.authenticate!(keycode_params[:code])
      m.verify
      success!(m)
    else
      fail!("Could not log in")
    end
  end

  def self.path
    new_my_keycode_authentication_path
  end

  def self.friendly_name
    "Keycode"
  end

  private

  def keycode_params
    ActionController::Parameters.new(params).require(:keycode).permit(:code)
  end
end
