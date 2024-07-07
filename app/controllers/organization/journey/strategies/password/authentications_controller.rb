class Organization::Journey::Strategies::Password::AuthenticationsController < Organization::Journey::Strategies::BaseController
  def new
    add_breadcrumb "Password", new_organization_password_authentication_path
  end

  def create
    request.env["warden"].authenticate(:organization_password)
    if !request.env["warden"].authenticated?
      flash[:error] = "Unable to log in"
      redirect_back fallback_location: new_organization_password_authentication_path
      return
    end
    redirect_to Journey.basecamp || organization_members_path, status: :see_other
  end
end
