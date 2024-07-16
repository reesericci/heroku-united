class Api::Member::Actor::DiscoveriesController < Api::BaseController
  skip_before_action :ensure_authenticated
  def new
    if !params[:resource]&.present?
      render plain: "No resource provided", status: 400
      return
    end
    @acct = begin
      URI(params[:resource]).opaque.split("@") 
    rescue 
      render plain: "Invalid Resource URI", status: 400
      return
    end
    if @acct[1] != URI(Config.external_url)&.host && 
    @acct[1] != Config.external_url && 
    @acct[1] != URI(request.base_url).host
        render plain: "Resource doesn't exist here", status: 400
        return
    end
    
    @member = begin
      Member.find(@acct[0])
    rescue
      render plain: "Unable to find user", status: 400
      return
    end
    if @member.blank?
      render plain: "Unable to find user", status: 400
      return
    end
  end
  
  render formats: :json, content_type: "application/jrd+json"
end