class MembersController < ApplicationController
  include Authenticate
  include ActiveSupport::Inflector

  def index
    @members = Member.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.csv { render csv: @members.to_csv, filename: "#{parameterize(Time.zone.now.iso8601).upcase}-#{parameterize(Config.organization)}-members" }
    end
  end

  def edit
    @member = Member.include_deceased.find_by(username: params[:username])
  end

  def update
    member = Member.include_deceased.find_or_create_by!(username: params[:username])
    if member.deceased?
      member.resurrect
    end
    member.update!(member_params)
    if member.address
      member.address.update!(address_params)
    elsif Address.new(address_params.merge({addressable_id: member.id, addressable_type: "Member"})).valid?
      member.update!(address: Address.new(address_params.merge({addressable_id: member.id, addressable_type: "Member"})))
    end
    redirect_to members_path
  end

  def destroy
    member = Member.include_deceased.find_by(username: params[:username])
    if member.deceased?
      member.cremate!
    else
      member.decease
    end
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
