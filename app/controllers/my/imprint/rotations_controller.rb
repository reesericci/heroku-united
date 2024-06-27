class My::Imprint::RotationsController < My::BaseController
  def new
    Keycode::Imprint.find_by(imprintor_id: request.env["warden"].user(:my), imprintor_type: :member)&.rotate!
    redirect_back_or_to my_membership_path
  end
end
