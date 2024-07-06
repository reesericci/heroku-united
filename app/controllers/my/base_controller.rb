class My::BaseController < ApplicationController
  before_action :ensure_authenticated

  add_breadcrumb "My", :my_root_path

  def ensure_authenticated
    if !request.env["warden"].authenticated?(:my)
      Journey.basecamp = request.env["PATH_INFO"]
      redirect_to new_my_journey_path
    else
      My.member = request.env["warden"].user(:my)
    end
  end
end
