class My::Imprint::RotationsController < My::BaseController
  def create
    request.env["warden"].user(:my)&.keycode_imprint&.rotate!
    redirect_back fallback_location: "/my/membership", status: 303
  end
end
