class My::Membership::RenewalsController < My::BaseController
  def create
    request.env[:warden].user(:my)&.renew
    redirect_back fallback_location: "/my/membership", status: 303
  end
end
