class Api::Member::ActorsController < Api::BaseController
  def show
    @member = Member.find(params[:username])
    
    render formats: :json, content_type: "application/ld+json"
  end
end