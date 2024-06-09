class MembersController < ApplicationController
  include Authenticate

  def index
    @members = Member.all.sort_by(&:created_at).reverse
  end

  def edit
    @member = Member.find_by(username: params[:username])
  end

  def update
    member = Member.find_or_create_by!(username: params[:username])
    member.update!(member_params)
    if member.address
      member.address.update!(address_params)
    elsif Address.new(address_params.merge({addressable_id: member.id, addressable_type: "Member"})).valid?
      member.update!(address: Address.new(address_params.merge({addressable_id: member.id, addressable_type: "Member"})))
    end
    redirect_to members_path
  end

  def destroy
    member = Member.find_by(username: params[:username])
    member.destroy!
    redirect_to members_path, status: 303
  end

  private

  def member_params
    params.require(:member).permit(:name, :username, :email, :expires_at, :banned)
  end

  def address_params
    params.require(:member).permit(address_attributes: [:line1, :line2, :city, :province, :code, :country])[:address_attributes]
  end
end
