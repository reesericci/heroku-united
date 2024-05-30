class Identity::PostmarksController < ApplicationController
  def new
  end

  def create
    @member = Member.find_by(username: member_params[:username])
    Identity::PostmarkMailer.with(postmarkable: @member).new.deliver_later
    redirect_to new_identity_login_path, status: :see_other, flash: {postmark_member_username: @member.username}
  end

  private

  def member_params
    params.require(:member).permit(:username)
  end
end
