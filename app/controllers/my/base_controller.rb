class My::BaseController < ApplicationController
  before_action :ensure_authenticated

  def ensure_authenticated
    if !request.env["warden"].authenticated?(:my)
      Journey.basecamp = request.env["PATH_INFO"]
      redirect_to new_my_journey_path
    else
      My.member = request.env["warden"].user(:my)
    end
  end
end
