class DiscoveriesMiddleware
  def initialize(app)
    @app = app
  end
  
  def call(env)
    # reroute webfinger if basic credentials are provided to the API
    if env["PATH_INFO"] == "/.well-known/webfinger" && ActionController::HttpAuthentication::Basic.has_basic_credentials?(ActionDispatch::Request.new(env))
      Api::Member::Actor::DiscoveriesController.action(:new).call(env)
    else
      @app.call(env)
    end    
  end
end
