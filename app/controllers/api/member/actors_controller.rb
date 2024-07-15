class Api::Member::ActorsController < Api::BaseController
  def show
    @member = Member.find(params[:username])
  end
end