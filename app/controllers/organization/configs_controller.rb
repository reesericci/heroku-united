class Organization::ConfigsController < Organization::BaseController
  skip_before_action :ensure_configured, :ensure_authenticated, only: [:new, :create]

  def new
    if Config.first
      redirect_to organization_members_path, flash: {error: "This instance is already configured"}
    end
  end

  def create
    if Config.first
      redirect_to organization_members_path, flash: {error: "This instance is already configured"}
      return
    end
    c = Config.new(config_params)
    c.save!
    redirect_to organization_members_path
  end

  def show
  end

  def update
    c = Config.first
    c.assign_attributes(config_params)
    if c.invalid?
      errors = "<ul>"
      c.errors.full_messages.each do |e|
        errors += "<li>#{e}</li>"
      end
      errors += "</ul>"
      flash.now[:error] = errors
      render :show, status: :unprocessable_entity
      return
    end
    c.save!
    redirect_back fallback_location: organization_config_path
  end

  private

  def config_params
    params.require(:config).permit(:organization, :external_url, :membership_length, :email, :password, :stripe_publishable_key, :stripe_secret_key, :payments, extensions: [], smtp: [:server, :port, :username, :password, :box, :domain])
  end
end
