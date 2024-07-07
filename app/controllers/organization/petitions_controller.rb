class Organization::PetitionsController < Organization::BaseController
  add_breadcrumb "Clearance Petitions", :organization_petitions_path
  def index
    @members = Member.petitioners
  end
end
