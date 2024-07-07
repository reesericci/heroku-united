class Organization::Journey::BaseController < Organization::BaseController
  layout "organization/journeys"

  skip_before_action :ensure_authenticated

  add_breadcrumb "Journey", :new_organization_journey_path
end
