class MembersController < ApplicationController
  include Authenticatable

  def index
    @members = Member.all.sort_by(&:created_at).reverse
  end

  def edit
    @member = Member.find_by(username: params[:username])
  end

  def update
    member = Member.find_or_create_by(username: params[:username])
    member.update!(member_params)
    redirect_to members_path
  end

  def destroy
    member = Member.find_by(username: params[:username])
    member.destroy!
    redirect_to members_path, status: 303
  end

  private

  # Using a private method to encapsulate the permissible parameters
  # is just a good pattern since you'll be able to reuse the same
  # permit list between create and update. Also, you can specialize
  # this method with per-user checking of permissible attributes.
  def member_params
    params.require(:member).permit(:name, :username, :email, :expires_at, :banned)
  end
end
