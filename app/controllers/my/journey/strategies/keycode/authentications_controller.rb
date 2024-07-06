class My::Journey::Strategies::Keycode::AuthenticationsController < My::Journey::Strategies::BaseController
  def new
    if Journey.explorer.blank?
      redirect_to new_my_journey_path and return
    end

    code = Journey.explorer.keycode_imprint.code.rotate!.to_i
    KeycodeMailer.with(imprintor: Journey.explorer, code: code).new.deliver_later unless !Journey.explorer.keycode_imprint.email?

    @username = Journey.explorer.username
    add_breadcrumb "Keycode", new_my_keycode_authentication_path
  end

  def create
    request.env["warden"].authenticate(:my_keycode, scope: :my)
    if !request.env["warden"].authenticated?(:my)
      flash[:error] = "Unable to log in"
      redirect_back fallback_location: new_my_keycode_authentication_path
      return
    end
    if Journey.basecamp.blank?
      flash[:error] = "We don't know where you're visiting. Try restarting this flow again from the beginning."
      redirect_back fallback_location: new_my_keycode_authentication_path
      return
    end
    redirect_to Journey.basecamp, status: :see_other
  end
end
