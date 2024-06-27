class My::Membership::RenewalsController < My::BaseController
  def new
    request.env[:warden].user(:my).renew
    redirect_back fallback_location: "/my/membershipship", status: 303
  end
end
