class Organization::MembersController < Organization::BaseController
  include ActiveSupport::Inflector

  def index
    @members = Member.order(created_at: :desc)
    respond_to do |format|
      format.html
      format.csv { render csv: @members.to_csv, filename: "#{parameterize(Time.zone.now.iso8601).upcase}-#{parameterize(Config.organization)}-members" }
    end
  end

  def show
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
    params[:member][:extensions_attributes].each do |i|
      if member.extensions.find_by(name: i[1].keys.first).present?
        member.extensions.find_by(name: i[1].keys.first).update!(content: i[1][i[1].keys.first])
      else
        member.extensions.create!(name: i[1].keys.first, content: i[1][i[1].keys.first])
      end
    end
    redirect_to organization_members_path
  end

  def destroy
    member = Member.include_deceased.find_by(username: params[:username])
    if member.deceased?
      member.cremate!
    else
      member.decease
    end
    redirect_to organization_members_path, status: 303
  end

  private

  def member_params
    params.require(:member).permit(:name, :username, :email, :expires_at, :banned)
  end

  def address_params
    params.require(:member).permit(address_attributes: [:line1, :line2, :city, :province, :code, :country])[:address_attributes]
  end
end
