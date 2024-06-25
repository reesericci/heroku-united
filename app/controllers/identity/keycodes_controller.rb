class Identity::KeycodesController < ApplicationController
  def new
  end

  def create
    @member = Member.find_by(username: member_params[:username].downcase)
    KeycodeMailer.with(imprintor: @member).new.deliver_later unless !@member.keycode_imprint.email?
    redirect_to new_identity_login_path, status: :see_other, flash: {member_username: @member.username}
  end

  private

  def member_params
    params.require(:member).permit(:username)
  end
end
