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
    params.require(:member).permit(:name, :username, :email, :expires_at, :banned, address_attributes: [:line1, :line2, :city, :province, :code, :country], extensions_attributes: {})
  end
end
