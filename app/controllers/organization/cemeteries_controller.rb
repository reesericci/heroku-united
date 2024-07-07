class Organization::CemeteriesController < Organization::BaseController
  add_breadcrumb "Cemetery", :organization_cemetery_path
  def index
    @members = Member.cemetery
  end
end
