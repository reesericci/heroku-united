class My::Journey::BaseController < My::BaseController
  layout "my/journeys"

  skip_before_action :ensure_authenticated

  add_breadcrumb "Journey", :new_my_journey_path
end
