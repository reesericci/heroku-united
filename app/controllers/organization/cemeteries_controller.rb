class Organization::CemeteriesController < Organization::BaseController
  add_breadcrumb "Cemetery", :organization_members_path
  def index
    @members = Member.cemetery
  end
end
