class My::BaseController < ApplicationController
  before_action :ensure_authenticated

  def ensure_authenticated
    if !request.env["warden"].authenticated?(:my)
      session[:redirect] = request.env["PATH_INFO"]
      redirect_to new_my_keycode_path
    end
  end
end
