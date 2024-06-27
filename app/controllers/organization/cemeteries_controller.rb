class Organization::CemeteriesController < Organization::BaseController
  def index
    @members = Member.cemetery
  end
end
